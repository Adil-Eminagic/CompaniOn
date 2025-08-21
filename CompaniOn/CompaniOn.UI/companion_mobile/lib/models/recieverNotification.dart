import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:companion_mobile/models/users.dart';

part 'recieverNotification.g.dart';

@JsonSerializable(explicitToJson: true)
class RecieverNotification {
  int? id;
  int? senderId;
  Users? senderName;
  int? receiverId;
  String? title;
  String? message;
  bool? isRead;
  DateTime? createdAt;

  RecieverNotification(this.id, this.senderId, this.senderName, this.receiverId,
      this.title, this.message, this.isRead, this.createdAt);

  factory RecieverNotification.fromJson(Map<String, dynamic> json) {
    var notification = _$RecieverNotificationFromJson(json);

    if (json['sender'] != null) {
      print("Sender exists: ${json['sender']}");
      notification.senderName = Users.fromJson(json['sender']);
    } else {
      print("Sender is null or missing");
    }

    print("Receiver Notification: ${notification.senderName}");

    return notification;
  }

  Map<String, dynamic> toJson() => _$RecieverNotificationToJson(this);
}
