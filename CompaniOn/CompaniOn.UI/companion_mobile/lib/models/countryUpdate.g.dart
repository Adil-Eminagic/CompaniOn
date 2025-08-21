// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countryUpdate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryUpdate _$CountryUpdateFromJson(Map<String, dynamic> json) =>
    CountryUpdate(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['abbreviation'] as String?,
      json['isActive'] as bool?,
    );

Map<String, dynamic> _$CountryUpdateToJson(CountryUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'isActive': instance.isActive,
    };
