import 'package:json_annotation/json_annotation.dart';
import 'photos.dart';

part 'albums.g.dart';

@JsonSerializable()
class Albums {
  String? name;
  String? description;
  int? userId;
  int? coverPhotoId;
  Photos? coverPhoto;
  int? id;
  DateTime? createdAt;
  DateTime? modifiedAt;

  Albums(this.name, this.description, this.userId, this.coverPhotoId, this.coverPhoto, this.id, this.createdAt, this.modifiedAt);
  factory Albums.fromJson(Map<String, dynamic> json) => _$AlbumsFromJson(json);
 
  Map<String, dynamic> toJson() => _$AlbumsToJson(this);
}
