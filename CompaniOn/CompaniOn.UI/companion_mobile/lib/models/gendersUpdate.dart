import 'package:json_annotation/json_annotation.dart';

part 'gendersUpdate.g.dart';

@JsonSerializable()
class GendersUpdate{
  int? id; 
  String? value;

  GendersUpdate(this.value, this.id);
  factory GendersUpdate.fromJson(Map<String, dynamic> json) => _$GendersUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GendersUpdateToJson(this);
}