// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recieverNotificationInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecieverNotificationInsert _$RecieverNotificationInsertFromJson(
        Map<String, dynamic> json) =>
    RecieverNotificationInsert(
      (json['id'] as num?)?.toInt(),
      (json['senderId'] as num?)?.toInt(),
      (json['receiverId'] as num?)?.toInt(),
      json['title'] as String?,
      json['message'] as String?,
      json['isRead'] as bool?,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RecieverNotificationInsertToJson(
        RecieverNotificationInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'title': instance.title,
      'message': instance.message,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
