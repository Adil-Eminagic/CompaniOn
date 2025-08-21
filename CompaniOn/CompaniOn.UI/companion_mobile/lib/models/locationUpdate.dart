import 'package:json_annotation/json_annotation.dart';

part 'locationUpdate.g.dart';

@JsonSerializable()
class LocationUpdate{
  int? id; 
  int? userId; 
  int? latitude;
  int? longitude;

  LocationUpdate(this.userId, this.latitude, this.longitude, this.id);
  factory LocationUpdate.fromJson(Map<String, dynamic> json) => _$LocationUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LocationUpdateToJson(this);
}