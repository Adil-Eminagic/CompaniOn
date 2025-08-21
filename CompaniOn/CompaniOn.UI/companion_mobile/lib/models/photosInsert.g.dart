// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photosInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotosInsert _$PhotosInsertFromJson(Map<String, dynamic> json) => PhotosInsert(
      json['data'] as String?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PhotosInsertToJson(PhotosInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
    };
