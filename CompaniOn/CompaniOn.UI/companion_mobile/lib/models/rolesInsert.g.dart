// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rolesInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RolesInsert _$RolesInsertFromJson(Map<String, dynamic> json) => RolesInsert(
      json['value'] as String?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RolesInsertToJson(RolesInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };
