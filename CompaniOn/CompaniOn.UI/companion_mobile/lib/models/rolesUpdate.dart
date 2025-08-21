import 'package:json_annotation/json_annotation.dart';

part 'rolesUpdate.g.dart';

@JsonSerializable()
class RolesUpdate{
  int? id; 
  String? value;

  RolesUpdate(this.value, this.id);
  factory RolesUpdate.fromJson(Map<String, dynamic> json) => _$RolesUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RolesUpdateToJson(this);
}