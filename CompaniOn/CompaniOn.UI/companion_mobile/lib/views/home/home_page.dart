import 'dart:async';

import 'package:companion_mobile/models/aiConversation.dart';
import 'package:companion_mobile/models/aiConversationInsert.dart';
import 'package:companion_mobile/models/familyLink.dart';
import 'package:companion_mobile/models/recieverNotification.dart';
import 'package:companion_mobile/models/recieverNotificationInsert.dart';
import 'package:companion_mobile/models/reminder.dart';
import 'package:companion_mobile/providers/aiConversation_provider.dart';
import 'package:companion_mobile/providers/familyLink_provider.dart';
import 'package:companion_mobile/providers/location_provider.dart';
import 'package:companion_mobile/providers/recieverNotification_provider.dart';
import 'package:companion_mobile/screens/recieverNotification_screen.dart';
import 'package:companion_mobile/utils/location_helper.dart';
import 'package:companion_mobile/providers/reminder_provider.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:companion_mobile/models/search_result.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:provider/provider.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:companion_mobile/providers/background_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.sendLocationMessage});
  Function? sendLocationMessage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Flutter3DController controller = Flutter3DController();
  final StreamController<String> _subtitleStreamController =
      StreamController<String>.broadcast();
  late AiConversationProvider _aiConversationProvider;
  late RecieverNotificationProvider _recieverNotificationProvider;
  late LocationProvider _locationProvider;
  late ReminderProvider _reminderProvider;
  late FamilyLinkProvider _familyLinkProvider;
  List<AiConversation> aiConversation = [];
  List<FamilyLink> familyLink = [];
  List<Reminder> _reminders = [];
  List<Map<String, dynamic>> chatHistory = [];
  final TextEditingController messageController = TextEditingController();
  SearchResult<AiConversation>? resultAiConvo;
  bool isLoading = true;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _voiceInput = '';
  late FlutterTts _flutterTts;
  final LocationService _locationService = LocationService();
  Timer? _reminderTimer;
  List<String> animationList = [];
  bool _backgroundImageAvailable = true;

  @override
  void initState() {
    super.initState();
    _showInitialLoading();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _aiConversationProvider = context.read<AiConversationProvider>();
    _locationProvider = context.read<LocationProvider>();
    _familyLinkProvider = context.read<FamilyLinkProvider>();
    if (loggedUser?.roleId == 1) {
      addLocation();
    }
    _recieverNotificationProvider =
        context.read<RecieverNotificationProvider>();
    _familyLinkProvider = context.read<FamilyLinkProvider>();

    controller.onModelLoaded.addListener(() async {
      if (controller.onModelLoaded.value) {
        debugPrint('Model is loaded: ${controller.onModelLoaded.value}');
        await Future.delayed(const Duration(seconds: 5));
        await playAniFirst(controller);
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        animationList = await controller.getAvailableAnimations();
        setState(() {
          isLoading = false;
          _setMaleVoice();
          controller.playAnimation(animationName: animationList[1]);
          _speak("Hello, how can I assist you today?");
        });
        await Future.delayed(const Duration(seconds: 3));
        controller.playAnimation(animationName: animationList[0]);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final background = context.read<BackgroundProvider>().currentBackground;
      if (background.isNotEmpty) {
        final image = NetworkImage(background);
        final completer = Completer<void>();
        final imgStream = image.resolve(const ImageConfiguration());
        final listener = ImageStreamListener((_, __) {
          completer.complete();
        }, onError: (dynamic _, __) {
          setState(() {
            _backgroundImageAvailable = false;
          });
          completer.complete();
        });
        imgStream.addListener(listener);
        await completer.future;
        imgStream.removeListener(listener);
      }
    });
  }

  Future<void> _showInitialLoading() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoading = false;
    });
  }

  void addLocation() async {
    double latitude = 0, longitude = 0;

    var locationData = await _locationService.getCurrentLocation();
    if (locationData != null) {
      latitude = locationData.latitude ?? 0;
      longitude = locationData.longitude ?? 0;

      try {
        var request = {
          'userId': loggedUser?.id,
          "latitude": latitude,
          "longitude": longitude
        };

        await _locationProvider.insert(request);

        await widget.sendLocationMessage!(loggedUser);
      } catch (e) {
        alertBox(context, "Error", e.toString());
      }
    }
  }

  @override
  void dispose() {
    _subtitleStreamController.close();
    _reminderTimer?.cancel();
    messageController.dispose();
    super.dispose();
  }

  Future<void> _setMaleVoice() async {
    var voices = await _flutterTts.getVoices;
    await _flutterTts.setVoice(
        {"name": voices[350]["name"], "locale": voices[350]["locale"]});
  }

  Future<void> _speak(String message) async {
    await _flutterTts.setLanguage("en-US");
    await _setMaleVoice();
    await _flutterTts.setPitch(-100);

    List<String> words = message.split(' ');
    List<List<String>> chunks = [];

    for (int i = 0; i < words.length; i += 10) {
      chunks.add(
          words.sublist(i, (i + 10 > words.length) ? words.length : i + 10));
    }

    for (var chunk in chunks) {
      String chunkText = chunk.join(' ');

      _subtitleStreamController.add(chunkText);

      await _flutterTts.speak(chunkText);

      await Future.delayed(const Duration(seconds: 3));
    }
    controller.playAnimation(animationName: animationList[0]);
  }

  Future<void> _loadData() async {
    var dataAiConvo = await _aiConversationProvider.getPaged(filter: {});
    var dataReminders = await _reminderProvider.getPaged();

    setState(() {
      resultAiConvo = dataAiConvo;
      _reminders = dataReminders.items
          .where((reminder) => reminder.userId == loggedUser!.id)
          .toList();
    });
  }

  void _startReminderCheck() {
    _reminderTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkReminders();
    });
  }

  Future<void> _checkReminders() async {
    final now = DateTime.now();
    for (var reminder in _reminders) {
      if (!reminder.isAcknowledged) {
        if (reminder.repeat) {
          final nowTimeOnly = TimeOfDay(hour: now.hour, minute: now.minute);
          final reminderTimeOnly =
              TimeOfDay(hour: reminder.time.hour, minute: reminder.time.minute);
          if (nowTimeOnly == reminderTimeOnly) {
            _announceReminder(reminder);
            break;
          }
        } else {
          if (reminder.time.isBefore(now.add(Duration(seconds: 30))) &&
              reminder.time.isAfter(now.subtract(Duration(seconds: 30)))) {
            _announceReminder(reminder);
            break;
          }
        }
      }
    }
  }

  Future<void> _announceReminder(Reminder reminder) async {
    while (!reminder.isAcknowledged) {
      setState(() {
        chatHistory.add({
          "text": reminder.message,
          "isAI": true,
        });
      });
      await _speak(reminder.message);
      await Future.delayed(const Duration(seconds: 10));

      if (chatHistory.isNotEmpty &&
          chatHistory.last["text"].toLowerCase().contains("ok")) {
        setState(() {
          reminder.isAcknowledged = true;
        });
        setState(() {
          chatHistory.add({
            "text": "Thank you for acknowledging the reminder.",
            "isAI": true,
          });
        });
        _speak("Thank you for acknowledging the reminder.");
      }
    }
  }

  void sendMessage(String message, {bool isAI = false}) async {
    if (message.isNotEmpty) {
      setState(() {
        chatHistory.add({
          "text": message,
          "isAI": isAI,
        });
      });

      if (!isAI) {
        var timestamp = DateTime.now();
        AiConversationInsert convoInsert = AiConversationInsert(
          loggedUser!.id,
          message,
          "",
          "",
          timestamp,
          null,
        );

        await _aiConversationProvider.insert(convoInsert);
        await reciveMessage();
      } else {
        controller.playAnimation(animationName: animationList[1]);
        await _speak(message);
        _flutterTts.setCompletionHandler(() {
          print("Speech finished!");
          controller.playAnimation(animationName: animationList[0]);
        });
        // await Future.delayed(const Duration(seconds: 3));
      }

      setState(() {
        _isListening = false;
        messageController.clear();
      });
    }
  }

  Future<void> reciveMessage() async {
    var lastMessage =
        await _aiConversationProvider.getLastEntry(loggedUser!.id!);
    sendMessage(lastMessage.response!, isAI: true);

    if (lastMessage.sentimentAnalysis != null &&
        lastMessage.sentimentAnalysis == "alarming") {
      familyLink = await _familyLinkProvider.getByUserId(loggedUser!.id!);
      for (var familyMember in familyLink) {
        RecieverNotificationInsert newNotification = RecieverNotificationInsert(
            null,
            loggedUser!.id,
            familyMember.familyMemberId,
            "Alert",
            "This message by your relative was worrying: ${lastMessage.question}",
            false,
            DateTime.now());
        await _recieverNotificationProvider.insert(newNotification);
      }
    }
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening' && _isListening) {
          _startListening();
        }
      },
      onError: (error) => debugPrint('Speech error: $error'),
    );

    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          setState(() {
            _voiceInput = result.recognizedWords;
            messageController.text = _voiceInput;
          });

          if (result.finalResult && _voiceInput.isNotEmpty) {
            sendMessage(_voiceInput);
            _voiceInput = '';
          }
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'CompaniOn',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Messages'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/myMessages');
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Contact users'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/allUsers');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Consumer<BackgroundProvider>(
                    builder: (context, backgroundProvider, _) {
                      final background = backgroundProvider.currentBackground;
                      if (background.isEmpty || !_backgroundImageAvailable) {
                        return Image.asset(
                          'assets/images/cozy-home.jpg',
                          fit: BoxFit.cover,
                        );
                      }
                      return Image.network(
                        background,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null ||
                              (loadingProgress.cumulativeBytesLoaded ==
                                  loadingProgress.expectedTotalBytes)) {
                            return child;
                          }
                          return Stack(
                            children: [
                              Image.network(
                                background,
                                fit: BoxFit.cover,
                                color: Colors.black.withOpacity(0.3),
                                colorBlendMode: BlendMode.darken,
                              ),
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/cozy-home.jpg',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: Flutter3DViewer(
                    activeGestureInterceptor: true,
                    progressBarColor: Colors.orange,
                    enableTouch: false,
                    onProgress: (double progressValue) {
                      debugPrint('Model loading progress: $progressValue');
                    },
                    onLoad: (String modelAddress) async {
                      debugPrint('Model loaded: $modelAddress');
                      controller.setCameraTarget(0.0, 1.367, -1.5);
                      controller.setCameraOrbit(0, 80, 0.000001);
                    },
                    onError: (String error) {
                      debugPrint('Model failed to load: $error');
                    },
                    controller: controller,
                    src: 'assets/models/business_man.glb',
                  ),
                ),
                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  ),
                if (!isLoading)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: StreamBuilder<String>(
                      stream: _subtitleStreamController.stream,
                      builder: (context, snapshot) {
                        String subtitleText = snapshot.data ??
                            "AI: Hello, how can I assist you today?";
                        return Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            subtitleText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage(messageController.text);
                  },
                  icon: const Icon(Icons.send),
                ),
                IconButton(
                  onPressed: () {
                    if (_isListening) {
                      _stopListening();
                    } else {
                      _startListening();
                    }
                  },
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_off),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> playAniFirst(Flutter3DController controller) async {
    controller.playAnimation();
    controller.setCameraTarget(0.0, 1.367, -1.5);
    controller.setCameraOrbit(0, 80, 0.00001);
  }

  Future<String?> showPickerDialog(String title, List<String> inputList) async {
    return await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 250,
          child: inputList.isEmpty
              ? Center(child: Text('$title list is empty'))
              : ListView.separated(
                  itemCount: inputList.length,
                  padding: const EdgeInsets.only(top: 16),
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, inputList[index]);
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${index + 1}'),
                            Text(inputList[index]),
                            const Icon(Icons.check_box_outline_blank),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider(color: Colors.grey, thickness: 0.6);
                  },
                ),
        );
      },
    );
  }
}
