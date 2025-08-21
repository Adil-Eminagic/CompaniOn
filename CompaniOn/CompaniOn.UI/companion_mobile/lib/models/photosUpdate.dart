import 'package:json_annotation/json_annotation.dart';

part 'photosUpdate.g.dart';

@JsonSerializable()
class PhotosUpdate{
  int? id; 
  String? data;

  PhotosUpdate(this.data, this.id);
  factory PhotosUpdate.fromJson(Map<String, dynamic> json) => _$PhotosUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PhotosUpdateToJson(this);
}