import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestSignalRPage(),
    );
  }
}

class TestSignalRPage extends StatefulWidget {
  @override
  _TestSignalRPageState createState() => _TestSignalRPageState();
}

class _TestSignalRPageState extends State<TestSignalRPage> {
  final HubConnection connection = HubConnectionBuilder()
      .withUrl(
        'http://10.0.2.2:5208/notificationHub', // Adjust the URL to match your backend
        HttpConnectionOptions(
          skipNegotiation: true,
          transport: HttpTransportType.webSockets,
        ),
      )
      .build();

  String connectionStatus = 'Not connected';
  String notificationMessage = 'No notifications yet';
  final int? userId = loggedUser!.id;

  @override
  void initState() {
    super.initState();
    _startConnection();
  }

  void triggerNotification(String title, String body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }

  Future<void> _startConnection() async {
    try {
      await connection.start();
      setState(() {
        connectionStatus = 'Connected to SignalR Hub';
      });
      print('Connected to SignalR Hub');

      // Register the user
      await connection.invoke('RegisterUser', args: [userId.toString()]);
      print('User registered with ID: $userId');

      // Listen for notifications from the server
      connection.on('ReceiveMessage', (message) {
        setState(() {
          notificationMessage = 'Notification received: ${message?[0]}';
        });
        print('Notification received: ${message?[0]}');
        triggerNotification('New Notification', message?[0]);
      });
    } catch (e) {
      setState(() {
        connectionStatus = 'Failed to connect: $e';
      });
      print('Error while connecting: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignalR Test Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              connectionStatus,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                  print("button pritisnut");
              
                if (connection.state == HubConnectionState.connected) {
                  print("uspostavljena konekcija");
                  print("UserId koji saljemo u metodu:$userId");
                  try {
                    await connection.invoke(
                      'NotifyFamilyMembers',
                      args: [userId, 'SOS Message from Flutter'],
                    );
                    print('SOS message sent successfully');
                  } catch (e) {
                    print('Error while sending message: $e');
                  }
                } else {
                  print('Connection is not established yet.');
                }
              },
              child: Text('Send SOS Message'),
            ),
            SizedBox(height: 20),
            Text(
              notificationMessage,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
