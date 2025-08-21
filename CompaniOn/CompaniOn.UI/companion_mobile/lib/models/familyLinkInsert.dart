import 'package:json_annotation/json_annotation.dart';

part 'familyLinkInsert.g.dart';

@JsonSerializable()
class FamilyLinkInsert{
  int? id; 
  int? userId;
  int? familyMemberId;
  String? status;
  bool? sharedLocation;
  bool? sharedReminders;

  FamilyLinkInsert(this.userId, this.familyMemberId, this.status, this.sharedLocation, this.sharedReminders, this.id);
  factory FamilyLinkInsert.fromJson(Map<String, dynamic> json) => _$FamilyLinkInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FamilyLinkInsertToJson(this);
}