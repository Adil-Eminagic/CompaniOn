import 'package:companion_mobile/models/country.dart';
import 'package:companion_mobile/models/genders.dart';
import 'package:companion_mobile/models/photos.dart';
import 'package:companion_mobile/models/roles.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable(explicitToJson: true)
class Users {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  DateTime? lastSignInAt;
  String? biography;
  DateTime? birthDate;
  bool? isActive;
  DateTime? purchaseDate;
  DateTime? expirationDate;
  bool? isActiveMembership;
  int? profilePhotoId;
  Photos? profilePhoto;
  int? countryId;
  Country? country;
  int? genderId;
  Genders? gender;
  int? roleId;
  Roles? role;
  int? id;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isVisibleToOthers;

  Users(
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.lastSignInAt,
      this.biography,
      this.birthDate,
      this.isActive,
      this.purchaseDate,
      this.expirationDate,
      this.isActiveMembership,
      this.profilePhotoId,
      this.profilePhoto,
      this.countryId,
      this.country,
      this.genderId,
      this.gender,
      this.roleId,
      this.role,
      this.id,
      this.createdAt,
      this.modifiedAt,
      this.isVisibleToOthers);
  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
