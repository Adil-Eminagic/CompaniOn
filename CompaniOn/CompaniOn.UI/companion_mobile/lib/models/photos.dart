import 'package:json_annotation/json_annotation.dart';

part 'photos.g.dart';

@JsonSerializable()
class Photos{
  String? data;
  int? id; 
  DateTime? createdAt;
  DateTime? modifiedAt;

  Photos(this.data, this.id, this.createdAt, this.modifiedAt);
  factory Photos.fromJson(Map<String, dynamic> json) => _$PhotosFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PhotosToJson(this);
}