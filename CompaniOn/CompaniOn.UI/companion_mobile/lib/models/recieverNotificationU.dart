import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recieverNotificationU.g.dart';

@JsonSerializable(explicitToJson: true)
class RecieverNotificationU {
  int? id;
  int? senderId;
  int? receiverId;
  String? title;
  String? message;
  bool? isRead;
  DateTime? createdAt;

  RecieverNotificationU({
    this.id,
    this.senderId,
    this.receiverId,
    this.title,
    this.message,
    this.isRead,
    this.createdAt,
  });

  factory RecieverNotificationU.fromJson(Map<String, dynamic> json) =>
      _$RecieverNotificationUFromJson(json);

  Map<String, dynamic> toJson() => _$RecieverNotificationUToJson(this);
}
