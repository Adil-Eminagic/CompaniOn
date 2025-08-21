import 'package:json_annotation/json_annotation.dart';

part 'gendersInsert.g.dart';

@JsonSerializable()
class GendersInsert{
  int? id; 
  String? value;

  GendersInsert(this.value, this.id);
  factory GendersInsert.fromJson(Map<String, dynamic> json) => _$GendersInsertFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GendersInsertToJson(this);
}