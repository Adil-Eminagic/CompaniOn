import 'package:companion_mobile/core/routes/app_routes.dart';
import 'package:companion_mobile/screens/notification_details.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:companion_mobile/providers/recieverNotification_provider.dart';
import 'package:companion_mobile/models/recieverNotification.dart';
import 'package:companion_mobile/models/recieverNotificationU.dart';
import 'package:companion_mobile/views/save/empty_save_page.dart'; // Import the EmptySavePage widget
import 'dart:io';
import 'dart:async';

class RecieverNotificationPage extends StatefulWidget {
  @override
  _RecieverNotificationPageState createState() =>
      _RecieverNotificationPageState();
}

class _RecieverNotificationPageState extends State<RecieverNotificationPage> {
  late RecieverNotificationProvider _notificationProvider;
  List<RecieverNotification> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _notificationProvider = context.read<RecieverNotificationProvider>();
    _fetchNotifications();
  }

  bool hasUnreadNotifications = false;

  Future<void> _fetchNotifications() async {
    try {
      final receiverId = loggedUser?.id;

      if (receiverId != null) {
        final notifications =
            await _notificationProvider.GetByReceiverId(receiverId);
        setState(() {
          _notifications = notifications;
          hasUnreadNotifications =
              _notifications?.any((n) => n.isRead == false) ?? false;
          _isLoading = false;
        });
      } else {
        throw Exception("User is not logged in.");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading notifications: $e')),
      );
    }
  }

  Future<void> _markAsRead(int notificationId) async {
    try {
      await _notificationProvider.markAsRead(notificationId);

      setState(() {
        final index = _notifications.indexWhere((n) => n.id == notificationId);
        if (index != -1) {
          _notifications[index].isRead = true;
        }
      });

      print("Notification marked as read.");
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change your color here
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ), 
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? const EmptySavePage() // Importovana EmptySavePage komponenta
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      final senderName = notification.senderName?.firstName;
                      final senderLastName = notification.senderName?.lastName;
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          // onTap: () async {
                          //   try {
                          //     if (notification.isRead == false) {
                          //       await _markAsRead(notification.id!);
                          //     }
                          //   } catch (e) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //           content: Text(
                          //               "Error updating notification: $e")),
                          //     );
                          //   }
                          // },
                          onTap: () async {
                            try {
                              if (notification.isRead == false) {
                                await _markAsRead(notification.id!);
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Error updating notification: $e")),
                              );
                            }
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return NotificationDetailsPage(
                                notificationId: notification.id,
                                senderName: senderName,
                                senderLastName: senderLastName,
                              );
                            }));
                          },
                          leading: const Icon(
                            Icons.account_circle_sharp,
                            size: 50,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (senderName != null && senderLastName != null)
                                Text(
                                  "From: $senderName $senderLastName",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              const SizedBox(height: 8),
                              Text(
                                notification.title ?? 'No Title',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          trailing: notification.isRead == true
                              ? const Icon(Icons.check,
                                  color: Colors.green) // Ikona za pročitano
                              : const Icon(Icons.notifications_active,
                                  color: Colors.red), // Ikona za nepročitano
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
