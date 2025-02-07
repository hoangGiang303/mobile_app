// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

PassRequest _$PassRequestFromJson(Map<String, dynamic> json) => PassRequest(
      newPassword: json['newPassword'] as String?,
      oldPassword: json['oldPassword'] as String?,
    );

Map<String, dynamic> _$PassRequestToJson(PassRequest instance) =>
    <String, dynamic>{
      'newPassword': instance.newPassword,
      'oldPassword': instance.oldPassword,
    };

ResetPassRequest _$ResetPassRequestFromJson(Map<String, dynamic> json) =>
    ResetPassRequest(
      email: json['email'] as String?,
      resetCode: json['resetCode'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$ResetPassRequestToJson(ResetPassRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'resetCode': instance.resetCode,
      'newPassword': instance.newPassword,
    };
