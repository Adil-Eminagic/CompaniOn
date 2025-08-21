import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:companion_mobile/core/routes/app_routes.dart';
import 'package:companion_mobile/core/routes/on_generate_route.dart';
import 'package:companion_mobile/core/themes/app_themes.dart';
import 'package:companion_mobile/providers/albumItems_provider.dart';
import 'package:companion_mobile/providers/album_provide.dart';
import 'package:companion_mobile/providers/background_provider.dart';
import 'package:companion_mobile/providers/country_provider.dart';
import 'package:companion_mobile/providers/message_provider.dart';
import 'package:companion_mobile/providers/reminder_provider.dart';
import 'package:companion_mobile/providers/sign_provide.dart';
import 'package:companion_mobile/providers/access_signIn_provider.dart';
import 'package:companion_mobile/providers/access_signUp_provider.dart';
import 'package:companion_mobile/providers/aiConversation_provider.dart';
import 'package:companion_mobile/providers/familyLink_provider.dart';
import 'package:companion_mobile/providers/genders_provider.dart';
import 'package:companion_mobile/providers/location_provider.dart';
import 'package:companion_mobile/providers/photos_provider.dart';
import 'package:companion_mobile/providers/roles_provider.dart';
import 'package:companion_mobile/providers/users_provider.dart';
import 'package:companion_mobile/screens/login_screen.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/views/profile/messages/all_users_page.dart';
import 'package:companion_mobile/views/profile/messages/chat_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:companion_mobile/providers/recieverNotification_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:companion_mobile/providers/purchased_items_provider.dart';

Future<void> main() async {
  void initializeNotifications() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification for test.',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Color(0xFF9D50DD),
          importance: NotificationImportance.High,
        ),
      ],
      debug: true,
    );
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PurchasedItemsProvider()),
      ChangeNotifierProvider(create: (_) => BackgroundProvider()),
      ChangeNotifierProvider(create: (_) => AlbumItemsProvider()),
      ChangeNotifierProvider(create: (_) => AlbumsProvider()),
      ChangeNotifierProvider(create: (_) => CountryProvider()),
      ChangeNotifierProvider(create: (_) => SignProvider()),
      ChangeNotifierProvider(create: (_) => AccessSignInProvider()),
      ChangeNotifierProvider(create: (_) => AccessSignUpProvider()),
      ChangeNotifierProvider(create: (_) => GendersProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => PhotosProvider()),
      ChangeNotifierProvider(create: (_) => RolesProvider()),
      ChangeNotifierProvider(create: (_) => UsersProvider()),
      ChangeNotifierProvider(create: (_) => FamilyLinkProvider()),
      ChangeNotifierProvider(create: (_) => AiConversationProvider()),
      ChangeNotifierProvider(create: (_) => ReminderProvider()),
      ChangeNotifierProvider(create: (_) => RecieverNotificationProvider()),
      ChangeNotifierProvider(create: (_) => MessageProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CompaniOn',
      theme: AppTheme.defaultTheme,
      onGenerateRoute: RouteGenerator.onGenerate,
      initialRoute: AppRoutes.login,
      routes: {
        '/myMessages': (context) =>
            ChatListPage(currentUserId: loggedUser?.id ?? 0),
        '/allUsers': (context) => AllUsersPage(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
