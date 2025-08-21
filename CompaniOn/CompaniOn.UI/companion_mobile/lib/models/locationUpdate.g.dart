// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationUpdate _$LocationUpdateFromJson(Map<String, dynamic> json) =>
    LocationUpdate(
      (json['userId'] as num?)?.toInt(),
      (json['latitude'] as num?)?.toInt(),
      (json['longitude'] as num?)?.toInt(),
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocationUpdateToJson(LocationUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
