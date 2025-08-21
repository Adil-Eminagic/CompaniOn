import 'package:json_annotation/json_annotation.dart';

part 'accessSignIn.g.dart';

@JsonSerializable()
class AccessSignIn{
  String? email;
  String? password;

  AccessSignIn(this.email, this.password);
  factory AccessSignIn.fromJson(Map<String, dynamic> json) => _$AccessSignInFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AccessSignInToJson(this);
}