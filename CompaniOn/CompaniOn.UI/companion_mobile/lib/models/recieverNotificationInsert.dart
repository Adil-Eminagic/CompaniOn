import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:companion_mobile/models/users.dart';

part 'recieverNotificationInsert.g.dart';

@JsonSerializable(explicitToJson: true)
class RecieverNotificationInsert {
  int? id;
  int? senderId;
  int? receiverId;
  String? title;
  String? message;
  bool? isRead;
  DateTime? createdAt;

  RecieverNotificationInsert(this.id, this.senderId, this.receiverId,
      this.title, this.message, this.isRead, this.createdAt);

  factory RecieverNotificationInsert.fromJson(Map<String, dynamic> json) => _$RecieverNotificationInsertFromJson(json);

  Map<String, dynamic> toJson() => _$RecieverNotificationInsertToJson(this);
}
