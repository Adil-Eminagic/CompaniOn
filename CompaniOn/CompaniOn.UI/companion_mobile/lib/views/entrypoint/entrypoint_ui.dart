import 'package:companion_mobile/models/users.dart';
import 'package:companion_mobile/screens/member_home_page.screen.dart';
import 'package:companion_mobile/views/menu/menu_basic_users.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/views/profile/familyMembers/menu_container.dart';
import 'package:companion_mobile/views/profile/messages/all_users_page.dart';
import 'package:companion_mobile/views/profile/messages/chat_list_page.dart';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import '../../core/constants/app_defaults.dart';
import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../save/save_page.dart';
import 'components/app_navigation_bar.dart';

class EntryPointUI extends StatefulWidget {
  const EntryPointUI({super.key});

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  int currentIndex = 0;

  String SignlaRUrl = "http://10.0.2.2:5208/notificationHub";
  //String SignlaRUrl = "http://192.168.0.28:5000/notificationHub";

  late HubConnection connection = HubConnectionBuilder()
      .withUrl(
        SignlaRUrl, // defined in util file, change for emulator/real device
        HttpConnectionOptions(
          skipNegotiation: true,
          transport: HttpTransportType.webSockets,
        ),
      )
      .build();

  String connectionStatus = 'Not connected';
  final int? userId = loggedUser!.id;
  List<Widget> pages = [];

  @override
  void initState() {
    if (loggedUser!.roleId == 1) {
      pages = [
        HomePage(sendLocationMessage: sendLocationMessage),
        MenuContainer(familyMember: loggedUser),
        //const MenuPage(),
        const CartPage(isHomePage: true),
        const SavePage(isHomePage: false),
        const ProfilePage(),
      ];
    } else {
      pages = [
        const MemberHomePage(),
        const BasicUsersMenuPage(),
        //const MenuPage(),
        const CartPage(isHomePage: true),
        const SavePage(isHomePage: false),
        const ProfilePage(),
      ];
    }

    super.initState();
    _startConnection();
  }

  void _startConnection() async {
    try {
      await connection.start();
      setState(() {
        connectionStatus = 'Connected to SignalR Hub';
      });
      print('Connected to SignalR Hub');

      await connection.invoke('RegisterUser', args: [userId.toString()]);
      print('User registered with ID: $userId');

      connection.on('ReceiveMessage', (message) {
        setState(() {
          print('Notification received: ${message?[0]}');
          triggerNotification('SOS Message', message?[0]);
        });
      });

      connection.on('ReceiveLocation', (message) {
        setState(() {
          print('Location received: ${message?[0]}');
          //triggerNotification('Location Info', message?[0]);
        });
      });
    } catch (e) {
      setState(() {
        connectionStatus = 'Failed to connect: $e';
      });
      print('Error while connecting: $e');
    }
  }

  void triggerNotification(String title, String body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: "<font color='red'>$title</font>",
        body: "<font color='red'>${body}</font>",
        largeIcon: 'resource://drawable/warning',
        notificationLayout: NotificationLayout.Default,
        color: Color(0xFFFF0000),
      ),
    );
  }

  void sendSOSMessage(String? userName) async {
    if (connection.state == HubConnectionState.connected) {
      print("SOS Message sent with user ID: $userId");
      try {
        await connection.invoke(
          'NotifyFamilyMembers',
          args: [userId, '$userName needs help!'],
        );
        print('SOS message sent successfully');
      } catch (e) {
        print('Error while sending message: $e');
      }
    } else {
      print('Connection is not established yet.');
    }
  }

  void sendLocationMessage(Users familyMember) async {
    if (connection.state == HubConnectionState.connected) {
      print("Location Message sent with user ID: $userId");
      try {
        await connection.invoke(
          'NotifyAboutUserLocation',
          args: [
            familyMember.id,
            '${familyMember.firstName} ${familyMember.lastName} has changed location!'
          ],
        );
        print('Location Message message sent successfully');
      } catch (e) {
        print('Error while sending message: $e');
      }
    } else {
      print('Connection is not established yet.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: AppDefaults.duration,
        child: pages[currentIndex],
      ),
      floatingActionButton: (loggedUser!.roleId ==
              1) // Check if loggedUser.id == 1
          ? FloatingActionButton(
              onPressed: () {
                sendSOSMessage(loggedUser!.firstName);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Help is called!'),
                    duration: Duration(seconds: 2), // Duration of the message
                  ),
                );
              },
              backgroundColor: Colors.red,
              child: const Text(
                'SOS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null, // No floating button if loggedUser.id != 1
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
        onNavTap: onBottomNavigationTap,
      ),
    );
  }

  void onBottomNavigationTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
