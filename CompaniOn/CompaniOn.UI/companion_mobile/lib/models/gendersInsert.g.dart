// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gendersInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GendersInsert _$GendersInsertFromJson(Map<String, dynamic> json) =>
    GendersInsert(
      json['value'] as String?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GendersInsertToJson(GendersInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };
