// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albumItems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumItems _$AlbumItemsFromJson(Map<String, dynamic> json) => AlbumItems(
      json['description'] as String?,
      json['dateOfPhoto'] == null
          ? null
          : DateTime.parse(json['dateOfPhoto'] as String),
      (json['albumId'] as num?)?.toInt(),
      (json['photoId'] as num?)?.toInt(),
      json['photo'] == null
          ? null
          : Photos.fromJson(json['photo'] as Map<String, dynamic>),
      (json['id'] as num?)?.toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$AlbumItemsToJson(AlbumItems instance) =>
    <String, dynamic>{
      'description': instance.description,
      'dateOfPhoto': instance.dateOfPhoto?.toIso8601String(),
      'albumId': instance.albumId,
      'photoId': instance.photoId,
      'photo': instance.photo,
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
    };
