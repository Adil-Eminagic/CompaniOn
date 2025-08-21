import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country{
  int? id;
  String? name;
  String? abbreviation;
  bool? isActive;
  DateTime? createdAt;
  DateTime? modifiedAt;

  Country(this.id, this.name, this.abbreviation, this.isActive, this.createdAt, this.modifiedAt);
  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}