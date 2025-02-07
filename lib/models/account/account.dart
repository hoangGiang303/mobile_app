
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/models/profile/profile.dart';
part 'account.g.dart';
@JsonSerializable()
class AccountModel {
  @JsonKey(name: "_id")
  String? id;
  String? username;
  String? password;
  ProfileModel? profile;
  bool? admin;

  AccountModel({
    this.id,
    this.username,
    this.password,
    this.profile,
    this.admin,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}

@JsonSerializable()
class AccountResponse {
  final List<AccountModel> data;

  AccountResponse({required this.data});

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);
}

@JsonSerializable()
class DetailAccountResponse {
  final AccountModel? data;

  DetailAccountResponse({this.data});

  factory DetailAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailAccountResponseToJson(this);
}

@JsonSerializable()
class SignupModel {
  String? username;
  String? password;
  bool? admin;
  @JsonKey(name: "_id")
  String? id;

  SignupModel({
    this.username,
    this.password,
    this.admin,
    this.id,
  });
 factory SignupModel.fromJson(Map<String, dynamic> json) => _$SignupModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
}

@JsonSerializable()
class SignupResponse {
  String? message;
  final SignupModel? data;

  SignupResponse({this.data, this.message});

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}