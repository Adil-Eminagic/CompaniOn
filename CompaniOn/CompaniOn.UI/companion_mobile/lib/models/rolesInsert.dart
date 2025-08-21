import 'package:json_annotation/json_annotation.dart';

part 'rolesInsert.g.dart';

@JsonSerializable()
class RolesInsert{
  int? id; 
  String? value;

  RolesInsert(this.value, this.id);
  factory RolesInsert.fromJson(Map<String, dynamic> json) => _$RolesInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RolesInsertToJson(this);
}