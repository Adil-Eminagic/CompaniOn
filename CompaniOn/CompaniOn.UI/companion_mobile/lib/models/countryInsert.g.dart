// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countryInsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryInsert _$CountryInsertFromJson(Map<String, dynamic> json) =>
    CountryInsert(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['abbreviation'] as String?,
      json['isActive'] as bool?,
    );

Map<String, dynamic> _$CountryInsertToJson(CountryInsert instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'isActive': instance.isActive,
    };
