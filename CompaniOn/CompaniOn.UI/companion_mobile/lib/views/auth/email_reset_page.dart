import 'package:companion_mobile/providers/users_provider.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../core/routes/app_routes.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class EmailResetPage extends StatefulWidget {
  const EmailResetPage({super.key});

  @override
  State<EmailResetPage> createState() => _EmailResetPageState();
}

class _EmailResetPageState extends State<EmailResetPage> {
  late UsersProvider _userProvider = UsersProvider();
  final _key = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'currentEmail': Autentification.tokenDecoded?['Email'],
    };
    _userProvider = context.read<UsersProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('New Password'),
        backgroundColor: AppColors.scaffoldBackground,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(AppDefaults.margin),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                  vertical: AppDefaults.padding * 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppDefaults.borderRadius,
                ),
                child: FormBuilder(
                  key: _key,
                  initialValue: _initialValue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Current Email"),
                      const SizedBox(height: 8),
                      FormBuilderTextField(
                        name: 'currentEmail',
                        readOnly: true,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("New Email"),
                      const SizedBox(height: 8),
                      FormBuilderTextField(
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return mfield;
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Invalid email";
                          } else {
                            return null;
                          }
                        }),
                        name: 'newEmail',
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppDefaults.padding * 2),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            _key.currentState?.save();
                            try {
                              if (_key.currentState!.validate()) {
                                var res = await _userProvider.changeEmail(
                                    int.parse(
                                        Autentification.tokenDecoded?['Id']),
                                    _key.currentState?.value['newEmail']);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Email is successfully changed")));

                                Navigator.pushNamedAndRemoveUntil(
                                    context, AppRoutes.login, (route) => false);
                                Autentification.token = '';
                              }
                            } catch (e) {
                              String errorMessage =
                                  "An error occurred while changing email.";
                              if (e.toString().contains("Unauthorized")) {
                                errorMessage =
                                    "You are not authorized to change the email.";
                              } else if (e.toString().contains("Network")) {
                                errorMessage =
                                    "Please check your network connection.";
                              }
                              alertBox(context, "Error", errorMessage);
                            }
                          },
                          child: const Text('Done'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
