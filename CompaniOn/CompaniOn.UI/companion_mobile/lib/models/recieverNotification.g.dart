// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recieverNotification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecieverNotification _$RecieverNotificationFromJson(
        Map<String, dynamic> json) =>
    RecieverNotification(
      (json['id'] as num?)?.toInt(),
      (json['senderId'] as num?)?.toInt(),
      json['senderName'] == null
          ? null
          : Users.fromJson(json['senderName'] as Map<String, dynamic>),
      (json['receiverId'] as num?)?.toInt(),
      json['title'] as String?,
      json['message'] as String?,
      json['isRead'] as bool?,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RecieverNotificationToJson(
        RecieverNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'senderName': instance.senderName?.toJson(),
      'receiverId': instance.receiverId,
      'title': instance.title,
      'message': instance.message,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
