// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminderInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderInsert _$ReminderInsertFromJson(Map<String, dynamic> json) =>
    ReminderInsert(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num).toInt(),
      type: json['type'] as String,
      message: json['message'] as String,
      time: DateTime.parse(json['time'] as String),
      repeat: json['repeat'] as bool,
      isAcknowledged: json['isAcknowledged'] as bool,
    );

Map<String, dynamic> _$ReminderInsertToJson(ReminderInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'message': instance.message,
      'time': instance.time.toIso8601String(),
      'repeat': instance.repeat,
      'isAcknowledged': instance.isAcknowledged,
    };
