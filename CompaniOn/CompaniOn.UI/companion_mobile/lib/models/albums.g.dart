// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Albums _$AlbumsFromJson(Map<String, dynamic> json) => Albums(
      json['name'] as String?,
      json['description'] as String?,
      (json['userId'] as num?)?.toInt(),
      (json['coverPhotoId'] as num?)?.toInt(),
      json['coverPhoto'] == null
          ? null
          : Photos.fromJson(json['coverPhoto'] as Map<String, dynamic>),
      (json['id'] as num?)?.toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'userId': instance.userId,
      'coverPhotoId': instance.coverPhotoId,
      'coverPhoto': instance.coverPhoto,
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
    };
