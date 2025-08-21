import 'package:json_annotation/json_annotation.dart';
import 'photos.dart';

part 'albumItems.g.dart';

@JsonSerializable()
class AlbumItems {
  String? description;
  DateTime? dateOfPhoto;
  int? albumId;
  int? photoId;
  Photos? photo;
  int? id;
  DateTime? createdAt;
  DateTime? modifiedAt;

  AlbumItems(this.description, this.dateOfPhoto,this.albumId, this.photoId,
      this.photo, this.id, this.createdAt, this.modifiedAt);
  factory AlbumItems.fromJson(Map<String, dynamic> json) =>
      _$AlbumItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumItemsToJson(this);
}
