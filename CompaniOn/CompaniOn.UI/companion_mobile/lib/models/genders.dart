import 'package:json_annotation/json_annotation.dart';

part 'genders.g.dart';

@JsonSerializable()
class Genders{
  String? value;
  int? id; 
  DateTime? createdAt;
  DateTime? modifiedAt;

  Genders(this.value, this.id, this.createdAt, this.modifiedAt);
  factory Genders.fromJson(Map<String, dynamic> json) => _$GendersFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GendersToJson(this);
}