// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recieverNotificationU.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecieverNotificationU _$RecieverNotificationUFromJson(
        Map<String, dynamic> json) =>
    RecieverNotificationU(
      id: (json['id'] as num?)?.toInt(),
      senderId: (json['senderId'] as num?)?.toInt(),
      receiverId: (json['receiverId'] as num?)?.toInt(),
      title: json['title'] as String?,
      message: json['message'] as String?,
      isRead: json['isRead'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RecieverNotificationUToJson(
        RecieverNotificationU instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'title': instance.title,
      'message': instance.message,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
