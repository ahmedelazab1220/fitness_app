import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/auth/entity/login/login_request_entity.dart';

part 'login_request_dto.g.dart';

@JsonSerializable()
class LoginRequestDto {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "password")
  final String password;

  LoginRequestDto({required this.email, required this.password});

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

  factory LoginRequestDto.fromDomain(LoginRequestEntity entity) {
    return LoginRequestDto(email: entity.email, password: entity.password);
  }
}
