// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photosUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotosUpdate _$PhotosUpdateFromJson(Map<String, dynamic> json) => PhotosUpdate(
      json['data'] as String?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PhotosUpdateToJson(PhotosUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
    };
