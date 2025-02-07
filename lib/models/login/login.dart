import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class LoginRequest {
  final String? username;
  final String? password;

  LoginRequest({required this.username, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class PassRequest {
  final String? newPassword;
  final String? oldPassword;

  PassRequest({required this.newPassword, required this.oldPassword});

  factory PassRequest.fromJson(Map<String, dynamic> json) =>
      _$PassRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PassRequestToJson(this);
}

@JsonSerializable()
class ResetPassRequest {
  final String? email;
  final String? resetCode;
  final String? newPassword;


  ResetPassRequest({required this.email, required this.resetCode, required this.newPassword});

  factory ResetPassRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPassRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPassRequestToJson(this);
}
