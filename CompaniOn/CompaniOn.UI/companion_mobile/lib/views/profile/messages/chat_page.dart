import 'package:companion_mobile/models/message.dart';
import 'package:companion_mobile/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:signalr_core/signalr_core.dart';

class ChatPage extends StatefulWidget {
  final int currentUserId;
  final int otherUserId;
  final String otherUserName;

  const ChatPage({
    super.key,
    required this.currentUserId,
    required this.otherUserId,
    required this.otherUserName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late MessageProvider _messagesProvider;
  late HubConnection _hubConnection;

  List<Message> messages = [];
  bool isLoading = true;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messagesProvider = context.read<MessageProvider>();
    _loadMessages();

    _setupSignalRForMessages(() {
      _loadMessages();
    });
  }

  Future<void> _setupSignalRForMessages(Function onMessageReceived) async {
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          'http://10.0.2.2:5208/messageHub', // Zamijeni sa stvarnim URL-om
          HttpConnectionOptions(
            skipNegotiation: true,
            transport: HttpTransportType.webSockets,
          ),
        )
        .build();

    _hubConnection.onclose((error) {
      print('SignalR disconnected: $error');
    });

    _hubConnection.on('ReceiveMessageNotification', (arguments) {
      print("Nova poruka primljena (notifikacija)");
      onMessageReceived();
    });

    await _hubConnection.start();
    print('SignalR povezan');
  }

  Future<void> _loadMessages() async {
    try {
      final fetchedMessages = await _messagesProvider.getMessagesBetweenUsers(
        widget.currentUserId,
        widget.otherUserId,
      );
      setState(() {
        messages = fetchedMessages.reversed.toList();
        isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error loading messages: $e');
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    final newMessage = Message(
      id: 0,
      senderId: widget.currentUserId,
      receiverId: widget.otherUserId,
      content: content,
      createdAt: DateTime.now(),
    );

    try {
      final sentMessage = await _messagesProvider.insert(newMessage);
      setState(() {
        messages.add(sentMessage);
        _messageController.clear();
      });
      _scrollToBottom();
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  void dispose() {
    _hubConnection.stop();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.otherUserName}",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : messages.isEmpty
                    ? const Center(
                        child: Text(
                          "Say Hi!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(12),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = message.senderId == widget.currentUserId;
                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    isMe ? Colors.green[100] : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(message.content),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat('dd.MM.yyyy HH:mm')
                                        .format(message.createdAt),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
