// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['email'] as String?,
      json['phoneNumber'] as String?,
      json['lastSignInAt'] == null
          ? null
          : DateTime.parse(json['lastSignInAt'] as String),
      json['biography'] as String?,
      json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      json['isActive'] as bool?,
      json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      json['isActiveMembership'] as bool?,
      (json['profilePhotoId'] as num?)?.toInt(),
      json['profilePhoto'] == null
          ? null
          : Photos.fromJson(json['profilePhoto'] as Map<String, dynamic>),
      (json['countryId'] as num?)?.toInt(),
      json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      (json['genderId'] as num?)?.toInt(),
      json['gender'] == null
          ? null
          : Genders.fromJson(json['gender'] as Map<String, dynamic>),
      (json['roleId'] as num?)?.toInt(),
      json['role'] == null
          ? null
          : Roles.fromJson(json['role'] as Map<String, dynamic>),
      (json['id'] as num?)?.toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
      json['isVisibleToOthers'] as bool?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'lastSignInAt': instance.lastSignInAt?.toIso8601String(),
      'biography': instance.biography,
      'birthDate': instance.birthDate?.toIso8601String(),
      'isActive': instance.isActive,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'isActiveMembership': instance.isActiveMembership,
      'profilePhotoId': instance.profilePhotoId,
      'profilePhoto': instance.profilePhoto?.toJson(),
      'countryId': instance.countryId,
      'country': instance.country?.toJson(),
      'genderId': instance.genderId,
      'gender': instance.gender?.toJson(),
      'roleId': instance.roleId,
      'role': instance.role?.toJson(),
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'isVisibleToOthers': instance.isVisibleToOthers,
    };
