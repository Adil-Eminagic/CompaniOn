// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rolesUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RolesUpdate _$RolesUpdateFromJson(Map<String, dynamic> json) => RolesUpdate(
      json['value'] as String?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RolesUpdateToJson(RolesUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };
