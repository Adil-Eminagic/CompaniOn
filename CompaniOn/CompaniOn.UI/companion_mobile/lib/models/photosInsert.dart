import 'package:json_annotation/json_annotation.dart';

part 'photosInsert.g.dart';

@JsonSerializable()
class PhotosInsert{
  int? id; 
  String? data;

  PhotosInsert(this.data, this.id);
  factory PhotosInsert.fromJson(Map<String, dynamic> json) => _$PhotosInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PhotosInsertToJson(this);
}