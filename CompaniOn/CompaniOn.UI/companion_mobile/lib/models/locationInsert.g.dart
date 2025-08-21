// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationInsert _$LocationInsertFromJson(Map<String, dynamic> json) =>
    LocationInsert(
      (json['userId'] as num?)?.toInt(),
      (json['latitude'] as num?)?.toInt(),
      (json['longitude'] as num?)?.toInt(),
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocationInsertToJson(LocationInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
