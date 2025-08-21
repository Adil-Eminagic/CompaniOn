import 'package:json_annotation/json_annotation.dart';

part 'familyLink.g.dart';

@JsonSerializable()
class FamilyLink {
  int? userId;
  int? familyMemberId;
  String? status;
  bool? sharedLocation;
  bool? sharedReminders;
  int? id;
  String? kinship;
  DateTime? createdAt;
  DateTime? modifiedAt;

  FamilyLink(this.userId, this.familyMemberId, this.status, this.sharedLocation,
      this.sharedReminders, this.id, this.kinship, this.createdAt, this.modifiedAt);
  factory FamilyLink.fromJson(Map<String, dynamic> json) =>
      _$FamilyLinkFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FamilyLinkToJson(this);
}
