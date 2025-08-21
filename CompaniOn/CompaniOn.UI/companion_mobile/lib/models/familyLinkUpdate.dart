import 'package:json_annotation/json_annotation.dart';

part 'familyLinkUpdate.g.dart';

@JsonSerializable()
class FamilyLinkUpdate{
  int? id; 
  int? userId;
  int? familyMemberId;
  String? status;
  bool? sharedLocation;
  bool? sharedReminders;

  FamilyLinkUpdate(this.userId, this.familyMemberId, this.status, this.sharedLocation, this.sharedReminders, this.id);
  factory FamilyLinkUpdate.fromJson(Map<String, dynamic> json) => _$FamilyLinkUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FamilyLinkUpdateToJson(this);
}