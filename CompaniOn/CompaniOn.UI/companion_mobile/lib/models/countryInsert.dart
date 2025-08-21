import 'package:json_annotation/json_annotation.dart';

part 'countryInsert.g.dart';

@JsonSerializable()
class CountryInsert{
  int? id;
  String? name;
  String? abbreviation;
  bool? isActive;

  CountryInsert(this.id, this.name, this.abbreviation, this.isActive);
  factory CountryInsert.fromJson(Map<String, dynamic> json) => _$CountryInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CountryInsertToJson(this);
}