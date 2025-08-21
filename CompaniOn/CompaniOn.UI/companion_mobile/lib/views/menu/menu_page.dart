import 'package:companion_mobile/models/users.dart';
import 'package:companion_mobile/screens/location_tracker_screen.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import 'components/category_tile.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key,this.familyMemberId});
  final int? familyMemberId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            'Choose an action',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const CateogoriesGrid()
        ],
      ),
    );
  }
}

class CateogoriesGrid extends StatelessWidget {
  const CateogoriesGrid({
    super.key,
    this.familyMember
  });

  final Users? familyMember;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          if(loggedUser!.roleId==2)
          CategoryTile(
            imageLink: 'https://i.imgur.com/wJBopjL.png',
            label: 'Health',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.categoryDetails);
            },
          ),
          CategoryTile(
            imageLink: 'https://i.imgur.com/GPsRaFC.png',
            label: 'Reminders',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.reminder);
            },
          ),
          CategoryTile(
            imageLink: 'https://imgur.com/5a77Y0p.png',
            label: 'Location tracker',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  LocationTrackerScreen(familyMember: familyMember),
              ));
            },
          ),
        ],
      ),
    );
  }
}
