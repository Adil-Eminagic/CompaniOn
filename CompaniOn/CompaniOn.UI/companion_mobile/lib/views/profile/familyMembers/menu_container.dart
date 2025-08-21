import 'package:companion_mobile/core/routes/app_routes.dart';
import 'package:companion_mobile/models/users.dart';
import 'package:companion_mobile/screens/albums_screen.dart';
import 'package:companion_mobile/screens/location_history_screen.dart';
import 'package:companion_mobile/screens/location_tracker_screen.dart';
import 'package:companion_mobile/screens/reminder_page.dart';
import 'package:companion_mobile/screens/shop_page.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/views/menu/components/category_tile.dart';
import 'package:flutter/material.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer({super.key, this.familyMember});

  final Users? familyMember;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Menu of ${familyMember?.firstName ?? ""} ${familyMember?.lastName ?? ""}"),
          automaticallyImplyLeading: loggedUser?.roleId == 2,
        ),
        body: SafeArea(
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
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    if (loggedUser!.roleId == 2)
                      CategoryTile(
                        imageLink: 'https://i.imgur.com/wJBopjL.png',
                        label: 'Health',
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.healthPage);
                        },
                      ),
                    CategoryTile(
                      imageLink: 'https://i.imgur.com/GPsRaFC.png',
                      label: 'Reminders',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReminderPage(userId: familyMember!.id ?? 0),
                          ),
                        );
                      },
                    ),
                    CategoryTile(
                      imageLink: 'https://imgur.com/5a77Y0p.png',
                      label: (loggedUser!.roleId == 2)
                          ? 'Last location'
                          : 'My location',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              LocationTrackerScreen(familyMember: familyMember),
                        ));
                      },
                    ),
                    if (loggedUser!.roleId == 2)
                      CategoryTile(
                        imageLink: 'https://imgur.com/orBDSWx.png',
                        label: 'History',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LocationHistoryScreen(
                                familyMember: familyMember),
                          ));
                        },
                      ),
                    CategoryTile(
                      imageLink: 'https://imgur.com/4pT7ETo',
                      label: 'Albums',
                      hasIcon: true,
                      icon: Icons.image,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AlbumsPage(userId: familyMember?.id ?? 0),
                        ));
                      },
                    ),
                    if (loggedUser!.roleId == 1)
                    CategoryTile(
                      imageLink: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFnY6058vpwe1LF1LLhjrCkzya7s910J_Y7g&s',
                      label: 'Shop',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShopPage(),
                        ));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
