// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aiConversationUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiConversationUpdate _$AiConversationUpdateFromJson(
        Map<String, dynamic> json) =>
    AiConversationUpdate(
      (json['userId'] as num?)?.toInt(),
      json['question'] as String?,
      json['response'] as String?,
      json['sentimentAnalysis'] as String?,
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AiConversationUpdateToJson(
        AiConversationUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'question': instance.question,
      'response': instance.response,
      'sentimentAnalysis': instance.sentimentAnalysis,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
