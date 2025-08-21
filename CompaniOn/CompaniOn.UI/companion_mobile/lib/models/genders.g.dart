// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Genders _$GendersFromJson(Map<String, dynamic> json) => Genders(
      json['value'] as String?,
      (json['id'] as num?)?.toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$GendersToJson(Genders instance) => <String, dynamic>{
      'value': instance.value,
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
    };
