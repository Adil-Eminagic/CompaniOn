// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessSignUp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessSignUp _$AccessSignUpFromJson(Map<String, dynamic> json) => AccessSignUp(
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['email'] as String?,
      json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      json['phoneNumber'] as String?,
      json['password'] as String?,
      (json['countryId'] as num?)?.toInt(),
      (json['genderId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccessSignUpToJson(AccessSignUp instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'birthDate': instance.birthDate?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'countryId': instance.countryId,
      'genderId': instance.genderId,
    };
