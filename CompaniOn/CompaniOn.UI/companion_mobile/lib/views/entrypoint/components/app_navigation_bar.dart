import 'package:companion_mobile/models/recieverNotification.dart';
import 'package:companion_mobile/providers/recieverNotification_provider.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import 'bottom_app_bar_item.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late RecieverNotificationProvider _notificationProvider;
  List<RecieverNotification> _notifications = [];

  void initState() {
    super.initState();
    _notificationProvider = context.read<RecieverNotificationProvider>();
    _fetchNotifications();
  }
  
Future<void> _fetchNotifications() async {
    try {
      final receiverId = loggedUser?.id;

      if (receiverId != null) {
        final notifications =
            await _notificationProvider.GetByReceiverId(receiverId);
        setState(() {
          _notifications = notifications.where((notif) => notif.isRead==false)
            .toList();
        });
      } else {
        throw Exception("User is not logged in.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading notifications: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin,
      color: AppColors.scaffoldBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomAppBarItem(
            name: 'Home',
            iconLocation: AppIcons.home,
            isActive: widget.currentIndex == 0,
            onTap: () => widget.onNavTap(0),
          ),
          BottomAppBarItem(
            name: (loggedUser!.roleId==2)?'Family List':"Menu",
            iconLocation: AppIcons.menu,
            isActive: widget.currentIndex == 1,
            onTap: () => widget.onNavTap(1),
          ),
          const Padding(
            padding: EdgeInsets.all(AppDefaults.padding * 2),
            child: SizedBox(width: AppDefaults.margin),
          ),
          /* <---- We have to leave this 3rd index (2) for the cart item -----> */

                    Stack(
            children: [
              BottomAppBarItem(
                name: 'Notifications',
                iconLocation: AppIcons.profileNotification,
                isActive: widget.currentIndex == 5,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.receiverNotifications);
                },
              ),
              if (_notifications.isNotEmpty)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '${_notifications.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),

          BottomAppBarItem(
            name: 'Profile',
            iconLocation: AppIcons.profile,
            isActive: widget.currentIndex == 4,
            onTap: () => widget.onNavTap(4),
          ),
        ],
      ),
    );
  }
}
