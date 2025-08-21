import 'package:companion_mobile/providers/users_provider.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../core/routes/app_routes.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  late UsersProvider _userProvider = UsersProvider();
  final _key = GlobalKey<FormBuilderState>();

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Old Password"),
                      const SizedBox(height: 8),
                      FormBuilderTextField(
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return mfield;
                          }
                          {
                            return null;
                          }
                        }),
                        name: 'password',
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("New Password"),
                      const SizedBox(height: 8),
                      FormBuilderTextField(
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return mfield;
                          } else if (value.length < 8 ||
                              !value.contains(RegExp(r'[A-Z]')) ||
                              !value.contains(RegExp(r'[a-z]')) ||
                              !value.contains(RegExp(r'[0-9]'))) {
                            return "Password has to contain at least 8 characters, lowercase and uppercase letters and numbers";
                          } else {
                            return null;
                          }
                        }),
                        name: 'newPassword',
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Confirm Password"),
                      const SizedBox(height: 8),
                      FormBuilderTextField(
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return mfield;
                          } else if (value !=
                              _key.currentState?.value['newPassword']) {
                            return "New password and confirm password don't match";
                          } else {
                            return null;
                          }
                        }),
                        name: 'confirmPassword',
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
                                var res = await _userProvider.changePassword({
                                  'id': Autentification.tokenDecoded?['Id'],
                                  'password':
                                      _key.currentState?.value['password'],
                                  'newPassword':
                                      _key.currentState?.value['newPassword'],
                                  'confirmNewPassword': _key
                                      .currentState?.value['confirmPassword']
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Password is successfully changed")));

                                Navigator.pushNamedAndRemoveUntil(
                                    context, AppRoutes.login, (route) => false);
                                Autentification.token = '';
                              }
                            } catch (e) {
                              alertBox(context, "Error",
                                  "An error occurred while changing the password. Please try again.");
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
