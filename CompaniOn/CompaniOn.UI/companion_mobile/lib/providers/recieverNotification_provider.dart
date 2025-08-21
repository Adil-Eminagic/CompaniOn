import 'dart:convert';
import 'package:companion_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:companion_mobile/models/recieverNotification.dart';
import 'package:companion_mobile/models/recieverNotificationU.dart';

class RecieverNotificationProvider extends BaseProvider<RecieverNotification> {
  RecieverNotificationProvider() : super("Notification");

  List<RecieverNotification> notifications = [];

  @override
  RecieverNotification fromJson(data) {
    return RecieverNotification.fromJson(data);
  }

  Future<List<RecieverNotification>> GetByReceiverId(int receiverId) async {
    var url =
        "${BaseProvider.baseUrl}api/$endpoint/GetNotificationsForReceiver/$receiverId";

    var uri = Uri.parse(url);

    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      notifications = List<RecieverNotification>.from(
          data.map((item) => RecieverNotification.fromJson(item)));

      return notifications;
    } else {
      throw new Exception(
          "Failed to retrieve notifications. Please check the receiver ID and try again.");
    }
  }

  Future<void> markAsRead(int notificationId) async {
    try {
      var url =
          "${BaseProvider.baseUrl}api/$endpoint/MarkAsRead/$notificationId";
      print("URL: $url");
      var uri = Uri.parse(url);
      var headers = createHeaders();

      var response = await http.put(uri, headers: headers);

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(
            "Failed to mark notification as read. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
