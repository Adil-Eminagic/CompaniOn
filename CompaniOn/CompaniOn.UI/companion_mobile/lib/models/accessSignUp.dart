import 'package:json_annotation/json_annotation.dart';

part 'accessSignUp.g.dart';

@JsonSerializable()
class AccessSignUp {
  String? firstName;
  String? lastName;
  String? email;
  DateTime? birthDate;
  String? phoneNumber;
  String? password;
  int? countryId;
  int? genderId;

  AccessSignUp(this.firstName, this.lastName, this.email, this.birthDate,
      this.phoneNumber, this.password, this.countryId, this.genderId);

  factory AccessSignUp.fromJson(Map<String, dynamic> json) =>
      _$AccessSignUpFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AccessSignUpToJson(this);
}
