import 'package:companion_mobile/providers/sign_provide.dart';
import 'package:companion_mobile/screens/main_screen.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SignProvider _signProvider = SignProvider();
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _signProvider = context.read<SignProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'eBiblioteka ',
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 45,
                      fontWeight: FontWeight.w700),
                ),
              
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      label: Text("Email"), icon: Icon(Icons.mail)),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      label: Text('Password'),
                      icon: Icon(Icons.password)),
                ),
                const SizedBox(
                  height: 40,
                ),
                isLoading
                    ? const SpinKitRing(color: Colors.brown)
                    : ElevatedButton(
                        onPressed: () async {
                          if (mounted) {
                            setState(() {
                              isLoading = true;
                            });
                          }

                          var email = _emailController.text;
                          var password = _passwordController.text;

                          try {
                            var data =
                                await _signProvider.signIn(email, password);
                            var token = data['token'];
                            Autentification.token = token;
                            Autentification.tokenDecoded =
                                JwtDecoder.decode(token);

                               Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return const MainScreen();
                                }));
                          } catch (e) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text(
                                         "Error"),
                                      content: Text(e.toString()),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              if (mounted) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            },
                                            child: const Text('Ok'))
                                      ],
                                    ));
                          }
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(fontSize: 18),
                        )),
                const SizedBox(
                  height: 15,
                ),
                isLoading == true
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No profile",
                              style: const TextStyle(fontSize: 17)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MainScreen()));
                            },
                            child: Text(
                              "Sign up",
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
