import 'package:json_annotation/json_annotation.dart';

part 'roles.g.dart';

@JsonSerializable()
class Roles{
  String? value;
  int? id; 
  DateTime? createdAt;
  DateTime? modifiedAt;

  Roles(this.value, this.id, this.createdAt, this.modifiedAt);
  factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RolesToJson(this);
}