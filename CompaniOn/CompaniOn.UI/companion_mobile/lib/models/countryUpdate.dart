import 'package:json_annotation/json_annotation.dart';

part 'countryUpdate.g.dart';

@JsonSerializable()
class CountryUpdate{
  int? id;
  String? name;
  String? abbreviation;
  bool? isActive;

  CountryUpdate(this.id, this.name, this.abbreviation, this.isActive);
  factory CountryUpdate.fromJson(Map<String, dynamic> json) => _$CountryUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CountryUpdateToJson(this);
}