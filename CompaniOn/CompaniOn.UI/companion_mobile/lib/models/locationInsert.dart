import 'package:json_annotation/json_annotation.dart';

part 'locationInsert.g.dart';

@JsonSerializable()
class LocationInsert{
  int? id; 
  int? userId; 
  int? latitude;
  int? longitude;

  LocationInsert(this.userId, this.latitude, this.longitude, this.id);
  factory LocationInsert.fromJson(Map<String, dynamic> json) => _$LocationInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LocationInsertToJson(this);
}