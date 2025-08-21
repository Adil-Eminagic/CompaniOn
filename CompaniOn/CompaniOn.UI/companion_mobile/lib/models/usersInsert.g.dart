// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usersInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersInsert _$UsersInsertFromJson(Map<String, dynamic> json) => UsersInsert(
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['email'] as String?,
      json['phoneNumber'] as String?,
      json['biography'] as String?,
      json['password'] as String?,
      json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      json['isActive'] as bool?,
      json['profilePhoto'] as String?,
      (json['countryId'] as num?)?.toInt(),
      (json['genderId'] as num?)?.toInt(),
      (json['roleId'] as num?)?.toInt(),
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UsersInsertToJson(UsersInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'biography': instance.biography,
      'birthDate': instance.birthDate?.toIso8601String(),
      'genderId': instance.genderId,
      'roleId': instance.roleId,
      'countryId': instance.countryId,
      'isActive': instance.isActive,
      'profilePhoto': instance.profilePhoto,
    };
