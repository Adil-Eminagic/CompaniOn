// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'familyLink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyLink _$FamilyLinkFromJson(Map<String, dynamic> json) => FamilyLink(
      (json['userId'] as num?)?.toInt(),
      (json['familyMemberId'] as num?)?.toInt(),
      json['status'] as String?,
      json['sharedLocation'] as bool?,
      json['sharedReminders'] as bool?,
      (json['id'] as num?)?.toInt(),
      json['kinship'] as String?,
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$FamilyLinkToJson(FamilyLink instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'familyMemberId': instance.familyMemberId,
      'status': instance.status,
      'sharedLocation': instance.sharedLocation,
      'sharedReminders': instance.sharedReminders,
      'id': instance.id,
      'kinship': instance.kinship,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
    };
