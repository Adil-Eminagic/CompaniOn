import 'package:json_annotation/json_annotation.dart';

part 'usersUpdate.g.dart';

@JsonSerializable(explicitToJson: true)
class UsersUpdate{
  int? id; 
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? biography;
  DateTime? birthDate;
  int? genderId;
  int? roleId;
  int? countryId;
  bool? isActive;
  String? profilePhoto;

  UsersUpdate(this.firstName, this.lastName, this.email, this.phoneNumber,this.biography, this.password, this.birthDate, this.isActive, this.profilePhoto, this.countryId, this.genderId, this.roleId, this.id);
  factory UsersUpdate.fromJson(Map<String, dynamic> json) => _$UsersUpdateFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UsersUpdateToJson(this);
}