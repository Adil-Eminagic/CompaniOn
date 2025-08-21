// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'familyLinkInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyLinkInsert _$FamilyLinkInsertFromJson(Map<String, dynamic> json) =>
    FamilyLinkInsert(
      (json['userId'] as num?)?.toInt(),
      (json['familyMemberId'] as num?)?.toInt(),
      json['status'] as String?,
      json['sharedLocation'] as bool?,
      json['sharedReminders'] as bool?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FamilyLinkInsertToJson(FamilyLinkInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'familyMemberId': instance.familyMemberId,
      'status': instance.status,
      'sharedLocation': instance.sharedLocation,
      'sharedReminders': instance.sharedReminders,
    };
