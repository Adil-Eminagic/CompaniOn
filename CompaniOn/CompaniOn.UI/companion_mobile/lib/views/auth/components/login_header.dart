import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class LoginPageHeader extends StatefulWidget {
  const LoginPageHeader({super.key});

  @override
  _LoginPageHeaderState createState() => _LoginPageHeaderState();
}

class _LoginPageHeaderState extends State<LoginPageHeader> {

  @override
  void initState() {
      AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });


    super.initState();
  }

   

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.asset(
              'assets/images/login_logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Welcome',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 34,
                fontFamily: 'Jura',
              ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
