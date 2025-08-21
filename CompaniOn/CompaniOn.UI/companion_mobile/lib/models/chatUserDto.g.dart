// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatUserDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUserDto _$ChatUserDtoFromJson(Map<String, dynamic> json) => ChatUserDto(
      (json['userId'] as num).toInt(),
      json['otherUserName'] as String,
      json['lastMessage'] as String?,
      json['lastMessageTime'] == null
          ? null
          : DateTime.parse(json['lastMessageTime'] as String),
      json['hasNewMessages'] as bool,
      (json['unreadCount'] as num).toInt(),
    );

Map<String, dynamic> _$ChatUserDtoToJson(ChatUserDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'otherUserName': instance.otherUserName,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': instance.lastMessageTime?.toIso8601String(),
      'hasNewMessages': instance.hasNewMessages,
      'unreadCount': instance.unreadCount,
    };
