import 'package:companion_mobile/core/constants/app_colors.dart';
import 'package:companion_mobile/core/constants/app_defaults.dart';
import 'package:companion_mobile/views/profile/familyMembers/add_basic_user_form.dart';
import 'package:flutter/material.dart';

class AddBasicUserPage extends StatelessWidget {
  const AddBasicUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      appBar: AppBar(
        title: const Text('New Family Memeber',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: AppDefaults.padding),
                AddBasicUserForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
