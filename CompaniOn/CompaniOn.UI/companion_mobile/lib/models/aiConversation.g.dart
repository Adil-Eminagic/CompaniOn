// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aiConversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiConversation _$AiConversationFromJson(Map<String, dynamic> json) =>
    AiConversation(
      json['user'] == null
          ? null
          : Users.fromJson(json['user'] as Map<String, dynamic>),
      (json['userId'] as num?)?.toInt(),
      json['question'] as String?,
      json['response'] as String?,
      json['sentimentAnalysis'] as String?,
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      (json['id'] as num?)?.toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$AiConversationToJson(AiConversation instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'userId': instance.userId,
      'question': instance.question,
      'response': instance.response,
      'sentimentAnalysis': instance.sentimentAnalysis,
      'timestamp': instance.timestamp?.toIso8601String(),
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
    };
