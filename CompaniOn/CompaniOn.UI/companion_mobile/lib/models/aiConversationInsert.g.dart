// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aiConversationInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiConversationInsert _$AiConversationInsertFromJson(
        Map<String, dynamic> json) =>
    AiConversationInsert(
      (json['userId'] as num?)?.toInt(),
      json['question'] as String?,
      json['response'] as String?,
      json['sentimentAnalysis'] as String?,
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AiConversationInsertToJson(
        AiConversationInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'question': instance.question,
      'response': instance.response,
      'sentimentAnalysis': instance.sentimentAnalysis,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
