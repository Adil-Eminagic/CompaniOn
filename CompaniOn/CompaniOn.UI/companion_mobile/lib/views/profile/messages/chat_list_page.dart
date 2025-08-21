import 'package:companion_mobile/models/chatUserDto.dart';
import 'package:companion_mobile/providers/message_provider.dart';
import 'package:companion_mobile/views/profile/messages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Za korištenje Provider
import 'package:signalr_core/signalr_core.dart';

class ChatListPage extends StatefulWidget {
  final int currentUserId;

  const ChatListPage({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late Future<List<ChatUserDto>> _chatUsersFuture;
  late HubConnection _hubConnection;

  @override
  void initState() {
    super.initState();
    _chatUsersFuture =
        _loadChatUsers(); // Poziv MessageProvider-a za chat korisnike
    _setupSignalRForMessages(() {
      setState(() {
        _chatUsersFuture =
            _loadChatUsers(); // Ažuriraj chat korisnike kada se nova poruka primi
      });
    });
  }

  // Metoda za dohvat chat korisnika preko MessageProvider
  Future<List<ChatUserDto>> _loadChatUsers() async {
    final messageProvider =
        context.read<MessageProvider>(); // Pristup MessageProvider-u
    try {
      final chatUsers = await messageProvider
          .getChatUsers(widget.currentUserId); // Pozivanje metode u provideru
      return chatUsers;
    } catch (e) {
      print('Error loading chat users: $e');
      return []; // U slučaju greške vraćamo praznu listu
    }
  }

  // Funkcija za otvaranje chata s određenim korisnikom
  void openChat(ChatUserDto user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatPage(
          currentUserId: widget.currentUserId,
          otherUserId: user.userId,
          otherUserName: user.otherUserName,
        ),
      ),
    ).then((_) {
      // Ovdje pozivamo setState() kako bi se obnovili podaci o chat korisnicima
      setState(() {
        _chatUsersFuture = _loadChatUsers();
      });
    });
  }

  // SignalR konfiguracija za obavijesti o novim porukama
  Future<void> _setupSignalRForMessages(Function onMessageReceived) async {
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          'http://10.0.2.2:5208/messageHub', // Zamijeniti sa stvarnim URL-om
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
      onMessageReceived(); // Pozivanje funkcije za ponovno učitavanje korisnika
    });

    await _hubConnection.start();
    print('SignalR povezan');
  }

  @override
  void dispose() {
    _hubConnection.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
      ),
      body: FutureBuilder<List<ChatUserDto>>(
        future: _chatUsersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Greška: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chatUsers = snapshot.data!;

          return ListView.builder(
            itemCount: chatUsers.length,
            itemBuilder: (context, index) {
              final user = chatUsers[index];

              return ListTile(
                onTap: () => openChat(user),
                title: Text(
                  user.otherUserName,
                  style: TextStyle(
                    fontWeight: user.hasNewMessages
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                subtitle: Text(user.lastMessage ?? ''),
                trailing: user.hasNewMessages
                    ? CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${user.unreadCount}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
