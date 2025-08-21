import 'dart:io';

import 'package:companion_mobile/core/routes/app_routes.dart';
import 'package:companion_mobile/core/utils/validators.dart';
import 'package:companion_mobile/models/country.dart';
import 'package:companion_mobile/models/genders.dart';
import 'package:companion_mobile/models/photos.dart';
import 'package:companion_mobile/models/roles.dart';
import 'package:companion_mobile/models/search_result.dart';
import 'package:companion_mobile/providers/country_provider.dart';
import 'package:companion_mobile/providers/genders_provider.dart';
import 'package:companion_mobile/providers/photos_provider.dart';
import 'package:companion_mobile/providers/roles_provider.dart';
import 'package:companion_mobile/providers/users_provider.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _key = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late GendersProvider _genderProvider = GendersProvider();
  late CountryProvider _countryProvider = CountryProvider();
  late RolesProvider _roleProvider = RolesProvider();
  late UsersProvider _userProvider = UsersProvider();
  late PhotosProvider _photoProvider = PhotosProvider();

  SearchResult<Country>? countryResult;
  SearchResult<Genders>? genderResult;
  SearchResult<Roles>? roleResult;
  String? photo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'firstName': loggedUser?.firstName,
      'lastName': loggedUser?.lastName,
      'biography': loggedUser?.biography,
      'phoneNumber': loggedUser?.phoneNumber,
      'email': loggedUser?.email,
      'birthDate': loggedUser?.birthDate,
      'genderId': loggedUser?.genderId.toString(),
      'countryId': loggedUser?.countryId.toString(),
      'roleId': loggedUser?.roleId.toString(),
    };

    _genderProvider = context.read<GendersProvider>();
    _countryProvider = context.read<CountryProvider>();
    _roleProvider = context.read<RolesProvider>();
    _userProvider = context.read<UsersProvider>();
    _photoProvider = context.read<PhotosProvider>();

    initForm();
  }

  Future<void> initForm() async {
    countryResult = await _countryProvider.getPaged();
    genderResult = await _genderProvider.getPaged();
    roleResult = await _roleProvider.getPaged();
    if (loggedUser != null &&
        loggedUser!.profilePhotoId != null &&
        loggedUser!.profilePhotoId! > 0) {
      Photos p = await _photoProvider.getById(loggedUser!.profilePhotoId!);
      photo = p.data;
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const SpinKitRing(color: Colors.greenAccent)
            : FormBuilder(
                key: _key,
                initialValue: _initialValue,
                child: Container(
                  margin: const EdgeInsets.all(AppDefaults.padding),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding,
                    vertical: AppDefaults.padding * 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: AppDefaults.borderRadius,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // InkWell(
                      //         onTap: getimage,
                      //         child: Container(
                      //             constraints: const BoxConstraints(
                      //                 maxHeight: 350, maxWidth: 350),
                      //             child: imageFromBase64String(photo!)),
                      //       ),
                      // photo == null
                      //     ? ElevatedButton(
                      //         onPressed: getimage,
                      //         child: const Text(
                      //             "Choose_image"))
                      //     : Container(),

                      /* <----  First Name -----> */
                      const Text("First Name"),
                      textField('firstName'),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Last Name -----> */
                      const Text("Last Name"),
                      const SizedBox(height: 8),
                      textField('lastName'),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Birth Date -----> */
                      const Text("Birth Date"),
                      const SizedBox(height: 8),
                      FormBuilderDateTimePicker(
                        name: 'birthDate',
                        inputType: InputType.date,
                        validator: (value) {
                          if (value == null) {
                            return mfield;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Phone Number -----> */
                      const Text("Phone Number"),
                      const SizedBox(height: 8),
                      textField('phoneNumber'),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Email -----> */
                      const Text("Email"),
                      const SizedBox(height: 8),
                      FormBuilderTextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validators.email.call,
                        readOnly: true,
                        name: "email",
                      ),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Gender -----> */
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
                          filled: false,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                        ),
                        items: genderResult?.items
                                .map((g) => DropdownMenuItem(
                                      alignment: Alignment.centerLeft,
                                      value: g.id.toString(),
                                      child: Text(g.value ?? ''),
                                    ))
                                .toList() ??
                            [],
                      ),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Country -----> */
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
                          filled: false,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                        ),
                        items: countryResult?.items
                                .map((g) => DropdownMenuItem(
                                      alignment: Alignment.centerLeft,
                                      value: g.id.toString(),
                                      child: Text(g.name ?? ''),
                                    ))
                                .toList() ??
                            [],
                      ),
                      const SizedBox(height: AppDefaults.padding * 1.5),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.emailReset);
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDefaults.padding * 2,
                                  vertical: AppDefaults.padding,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Change email',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: AppDefaults.margin),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.passwordReset);
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDefaults.padding * 2,
                                  vertical: AppDefaults.padding,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Change password',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      /* <---- Submit -----> */
                      const SizedBox(height: AppDefaults.padding * 2),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Save'),
                          onPressed: () async {
                            _key.currentState?.save();

                            try {
                              if (_key.currentState!.validate()) {
                                Map<String, dynamic> request =
                                    Map.of(_key.currentState!.value);

                                request['id'] = loggedUser?.id;
                                request['roleId'] = loggedUser?.roleId;
                                request['birthDate'] = dateEncode(
                                    _key.currentState?.value['birthDate']);

                                if (_base64Image != null) {
                                  request['profilePhoto'] = _base64Image;
                                }

                                request['isActive'] = loggedUser!.isActive;

                                loggedUser =
                                    await _userProvider.update(request);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Profile is successfully modified")));

                                Navigator.pop(context);
                              }
                            } on Exception catch (e) {
                              alertBox(context, "Error",
                                  "An error occurred while saving your profile. Please try again.");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  File? _image; //dart.io
  String? _base64Image;

// Future getimage() async {
//   try {
//     var result = await FilePicker.platform.pickFiles(
//         type: FileType.image); //sam prepoznaj platformu u kjoj radi
//     if (result != null && result.files.single.path != null) {
//       _image = File(result
//           .files.single.path!); //jer smo sa if provjerili pa je sigurn !
//       _base64Image = base64Encode(_image!.readAsBytesSync());

//       if (mounted) {
//         setState(() {
//           photo = _base64Image; //opet !
//         });
//       }
//     }
//   } on Exception catch (e) {
//     alertBox(context,"Error", e.toString());
//   }
// }
}
