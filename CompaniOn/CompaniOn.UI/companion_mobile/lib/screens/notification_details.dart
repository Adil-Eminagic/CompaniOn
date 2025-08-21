import 'package:companion_mobile/models/recieverNotification.dart';
import 'package:companion_mobile/providers/recieverNotification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';

class NotificationDetailsPage extends StatefulWidget {
  const NotificationDetailsPage({super.key, this.notificationId, this.senderName, this.senderLastName});
  final int? notificationId;
  final String? senderName;
  final String? senderLastName;


  @override
  State<NotificationDetailsPage> createState() =>
      _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  late RecieverNotificationProvider _recieverNotificationProvider =
      RecieverNotificationProvider();
  bool isLoading = false;
  RecieverNotification? notification;

  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recieverNotificationProvider =
        context.read<RecieverNotificationProvider>();
    fetchNotification();
  }

  Future<void> fetchNotification() async {
    try {
      notification = await _recieverNotificationProvider
          .getById(widget.notificationId ?? 0);
      setState(() {
        isLoading = false;
         _senderController.text = "${widget.senderName} ${widget.senderLastName}";
        _titleController.text = notification?.title ?? '';
        _messageController.text = notification?.message ?? '';
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading notifications: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
            const Text('Notification details', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        ),
        backgroundColor: AppColors.scaffoldWithBoxBackground,
        body: SafeArea(
          child: Center(
            child: isLoading
                ? const SpinKitCircle(
                    color: Colors.green,
                  )
                : Container(
                    margin: const EdgeInsets.all(AppDefaults.margin),
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: AppDefaults.boxShadow,
                      borderRadius: AppDefaults.borderRadius,
                    ),
                    child: SizedBox(
                      height: 450,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("From"),
                                const SizedBox(height: 8),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _senderController,
                                ),
                                const SizedBox(height: AppDefaults.padding),
                                const Text("Title"),
                                const SizedBox(height: 8),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  controller: _titleController,
                                ),
                                const SizedBox(height: AppDefaults.padding),
                                const SizedBox(height: AppDefaults.padding),
                                const Text("Message"),
                                const SizedBox(height: 8),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  controller: _messageController,
                                  maxLines: 5,
                                ),
                                const SizedBox(height: AppDefaults.padding),
                              ]),
                        ),
                      ),
                    )),
          ),
        ));
  }
}
