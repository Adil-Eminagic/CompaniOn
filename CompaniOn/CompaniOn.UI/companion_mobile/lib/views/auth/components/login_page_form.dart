import 'package:companion_mobile/providers/sign_provide.dart';
import 'package:companion_mobile/providers/users_provider.dart';
import 'package:companion_mobile/utils/shared_resources.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_themes.dart';
import '../../../core/utils/validators.dart';
import 'login_button.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({
    super.key,
  });

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SignProvider _signProvider = SignProvider();
  late UsersProvider _usersProvider = UsersProvider();

  bool isLoading = false;

  bool isPasswordShown = false;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final String storedToken = await StoreData.instance.getString('token');

    // Navigate based on the login status
    if (storedToken.isNotEmpty) {

      Autentification.token = storedToken;
      Autentification.tokenDecoded = JwtDecoder.decode(storedToken);

      int userId = int.parse(Autentification.tokenDecoded!['Id']);
      loggedUser = await _usersProvider.getById(userId);
      // If token exists, navigate to the entry point
      if(loggedUser!.roleId==1){
        Navigator.pushNamed(context, AppRoutes.entryPoint);
      }
      else{
        Navigator.pushNamed(context, AppRoutes.entryPoint);
      }
    } 
  }


  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  onLogin() async {
    final bool isFormOkay = _key.currentState?.validate() ?? false;

    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    var email = _emailController.text;
    var password = _passwordController.text;
    try {
      var data = await _signProvider.signIn(email, password);
      var token = data['token'];

      print("TOKEEEENNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");

      StoreData.instance.saveString('token', token);

      Autentification.token = token;
      Autentification.tokenDecoded = JwtDecoder.decode(token);
      print("DEKODIRAN TOKEEEEEEEEEEEEN");
    
      int userId = int.parse(Autentification.tokenDecoded!['Id']);
      print("DOBAVILI USER IDDDDDD:");
      print(userId);
      
      loggedUser = await _usersProvider.getById(userId);

      print("DOBAVILI USERAAA PO ID");

      if (isFormOkay) {
        Navigator.pushReplacementNamed(context, AppRoutes.entryPoint);
      }
    } catch (e) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Wrong credentials"),
                content: Text(
                    "An error occurred during the login process. Please check your credentials or try again later."),
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
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Field
              const Text(
                "Email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17, // Email text color and size
                ),
              ),
              const SizedBox(height: 8),

              // Email Input Field
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email.call,
                textInputAction: TextInputAction.next,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Enter your email",
                  labelStyle: const TextStyle(
                    color: Colors.grey, // Label text color
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    // Rounded corners for enabled state
                    borderSide:
                        const BorderSide(color: Colors.grey), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    // Rounded corners for focused state
                    borderSide: const BorderSide(
                        color: Colors.blue), // Border color when focused
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black, // Input text color
                ),
              ),
              const SizedBox(height: 16),
              // Password Field
              const Text(
                "Password",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17, // Change the color of the "Password" text here
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                onFieldSubmitted: (v) => onLogin(),
                textInputAction: TextInputAction.done,
                controller: _passwordController,
                obscureText: !isPasswordShown,
                decoration: InputDecoration(
                  suffixIcon: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: onPassShowClicked,
                      icon: SvgPicture.asset(
                        AppIcons.eye,
                        width: 24,
                      ),
                    ),
                  ),
                  labelText: "Enter your password",
                  labelStyle: const TextStyle(
                    color: Colors.grey, // Label text color
                  ),
                  hintText: "********",
                  // Hint text if needed
                  hintStyle: const TextStyle(
                    color: Colors.grey, // Hint text color
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    // Rounded corners for enabled state
                    borderSide:
                        const BorderSide(color: Colors.grey), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    // Rounded corners for focused state
                    borderSide: const BorderSide(
                        color: Colors.blue), // Border color when focused
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black, // Input text color
                ),
              ),

              // Forget Password labelLarge
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("You've logged in successfuly")));
                  },
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              // Login labelLarge
              LoginButton(onPressed: onLogin),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
