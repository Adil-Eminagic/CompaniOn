// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gendersUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GendersUpdate _$GendersUpdateFromJson(Map<String, dynamic> json) =>
    GendersUpdate(
      json['value'] as String?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GendersUpdateToJson(GendersUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };
