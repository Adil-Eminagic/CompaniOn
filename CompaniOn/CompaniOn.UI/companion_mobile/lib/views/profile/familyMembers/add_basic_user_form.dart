import 'package:companion_mobile/models/country.dart';
import 'package:companion_mobile/models/genders.dart';
import 'package:companion_mobile/models/roles.dart';
import 'package:companion_mobile/models/search_result.dart';
import 'package:companion_mobile/providers/country_provider.dart';
import 'package:companion_mobile/providers/familyLink_provider.dart';
import 'package:companion_mobile/providers/genders_provider.dart';
import 'package:companion_mobile/providers/roles_provider.dart';
import 'package:companion_mobile/providers/sign_provide.dart';
import 'package:companion_mobile/providers/users_provider.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';

class AddBasicUserForm extends StatefulWidget {
  const AddBasicUserForm({super.key});

  @override
  State<AddBasicUserForm> createState() => _AddBasicUserFormState();
}

class _AddBasicUserFormState extends State<AddBasicUserForm> {
  final _key = GlobalKey<FormBuilderState>();
  late GendersProvider _genderProvider = GendersProvider();
  late CountryProvider _countryProvider = CountryProvider();
  late RolesProvider _rolesProvider = RolesProvider();
  late UsersProvider _usersProvider = UsersProvider();
  late FamilyLinkProvider _familyLinkProvider = FamilyLinkProvider();

  late SignProvider _signProvider = SignProvider();

  SearchResult<Country>? countryResult;
  SearchResult<Genders>? genderResult;
  SearchResult<Roles>? roleResult;
  bool isLoading = true;

  bool isPasswordShown = false;

  TextEditingController _kinshipTextController = TextEditingController();

  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _genderProvider = context.read<GendersProvider>();
    _countryProvider = context.read<CountryProvider>();
    _rolesProvider = context.read<RolesProvider>();
    _usersProvider = context.read<UsersProvider>();
    _familyLinkProvider = context.read<FamilyLinkProvider>();

    _signProvider = context.read<SignProvider>();

    intiForm();
  }

  Future<void> intiForm() async {
    try {
      countryResult = await _countryProvider.getPaged();
      genderResult = await _genderProvider.getPaged();
      roleResult = await _rolesProvider.getPaged();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      alertBoxMoveBack(context, "Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(AppDefaults.margin),
          padding: const EdgeInsets.all(AppDefaults.padding),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: AppDefaults.boxShadow,
            borderRadius: AppDefaults.borderRadius,
          ),
          child: isLoading
              ? const SpinKitRing(color: Colors.greenAccent)
              : FormBuilder(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("First Name"),
                      const SizedBox(height: 8),
                      _textField("firstName"),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Last Name"),
                      const SizedBox(height: 8),
                      _textField("lastName"),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Kinship"),
                      const SizedBox(height: 8),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _kinshipTextController,
                        validator:  ((value) {
                          if (value == null || value.isEmpty) {
                            return "Field is mandatory";
                          } else {
                            return null;
                          }
                        }),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Birth date"),
                      const SizedBox(height: 8),
                      FormBuilderDateTimePicker(
                        name: 'birthDate',
                        validator: (value) {
                          if (value == null) {
                            return mfield;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Phone Number"),
                      const SizedBox(height: 8),
                      _textField("phoneNumber"),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Gender"),
                      const SizedBox(height: 8),
                      FormBuilderDropdown<String>(
                        name: 'genderId',
                        validator: (value) {
                          if (value == null) {
                            return "Gender field is mandatory";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Gender",
                          suffix: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _key.currentState!.fields['genderId']?.reset();
                            },
                          ),
                        ),
                        items: genderResult?.items
                                .map((g) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: g.id.toString(),
                                      child: Text(g.value ?? ''),
                                    ))
                                .toList() ??
                            [],
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Country"),
                      const SizedBox(height: 8),
                      FormBuilderDropdown<String>(
                        name: 'countryId',
                        validator: (value) {
                          if (value == null) {
                            return "Country field is mandatory";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Country",
                          suffix: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _key.currentState!.fields['countryId']?.reset();
                            },
                          ),
                        ),
                        items: countryResult?.items
                                .map((g) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: g.id.toString(),
                                      child: Text(g.name ?? ''),
                                    ))
                                .toList() ??
                            [],
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Email"),
                      const SizedBox(height: 8),
                      FormBuilderTextField(
                        textInputAction: TextInputAction.next,
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "Email is mandatory";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Password is mandatory";
                          } else {
                            return null;
                          }
                        }),
                        keyboardType: TextInputType.text,
                        name: "email",
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const Text("Password"),
                      const SizedBox(height: 8),
                      FormBuilderTextField(
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return "Password is mandatory";
                          } else if (value.length < 8 ||
                              !value.contains(RegExp(r'[A-Z]')) ||
                              !value.contains(RegExp(r'[a-z]')) ||
                              !value.contains(RegExp(r'[0-9]'))) {
                            return "Password has to contain at least 8 characters, lowercase and uppercase letters and numbers.";
                          } else {
                            return null;
                          }
                        }),
                        textInputAction: TextInputAction.next,
                        obscureText: !isPasswordShown,
                        name: "password",
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
                        ),
                      ),
                      const SizedBox(height: AppDefaults.padding),
                      const SizedBox(height: AppDefaults.padding * 2),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text(
                            'Add',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                          ),
                          onPressed: () async {
                            try {
                              _key.currentState?.save();
                              if (_key.currentState!.validate()) {
                                Map<String, dynamic> request =
                                    Map.of(_key.currentState!.value);

                                request['birthDate'] = dateEncode(
                                    _key.currentState?.value['birthDate']);

                                request['isActive'] = true;

                                request['roleId'] = 1; // to do enum

                                var addedBasiUser =
                                    await _usersProvider.insert(request);

                                var familyLinkRequest = {
                                  'userId': addedBasiUser.id,
                                  'familyMemberId': loggedUser?.id, 
                                  "status": "string",
                                  "kinship": _kinshipTextController.text,
                                  "sharedLocation": false,
                                  "sharedReminders": false,
                                };

                                await _familyLinkProvider
                                    .insert(familyLinkRequest);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "You've successfully added a basic user")));

                                Navigator.pop(context, 'reload');
                              } else {}
                            } catch (e) {
                              alertBox(context, "Error", e.toString());
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: AppDefaults.padding),
                    ],
                  ),
                )),
    );
  }
}

FormBuilderTextField _textField(String name) {
  return FormBuilderTextField(
    name: name,
    validator: ((value) {
      if (value == null || value.isEmpty) {
        return "Field is mandatory";
      } else {
        return null;
      }
    }),
  );
}
