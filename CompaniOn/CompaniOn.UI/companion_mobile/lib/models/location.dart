import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location{
  int? userId; 
  double? latitude;
  double? longitude;
  int? id; 
  DateTime? createdAt;
  DateTime? modifiedAt;

  Location(this.userId, this.latitude, this.longitude, this.id, this.createdAt, this.modifiedAt);
  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}