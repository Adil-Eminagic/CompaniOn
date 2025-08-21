// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'familyLinkUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyLinkUpdate _$FamilyLinkUpdateFromJson(Map<String, dynamic> json) =>
    FamilyLinkUpdate(
      (json['userId'] as num?)?.toInt(),
      (json['familyMemberId'] as num?)?.toInt(),
      json['status'] as String?,
      json['sharedLocation'] as bool?,
      json['sharedReminders'] as bool?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FamilyLinkUpdateToJson(FamilyLinkUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'familyMemberId': instance.familyMemberId,
      'status': instance.status,
      'sharedLocation': instance.sharedLocation,
      'sharedReminders': instance.sharedReminders,
    };
