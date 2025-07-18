import 'package:json_annotation/json_annotation.dart';

import '../../../../../domain/auth/entity/forget_password/forget_password_request_entity.dart';

part 'forget_password_request_dto.g.dart';

@JsonSerializable()
class ForgetPasswordRequestDto {
  final String email;

  ForgetPasswordRequestDto({required this.email});

  factory ForgetPasswordRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestDtoToJson(this);

  factory ForgetPasswordRequestDto.fromDomain(
    ForgetPasswordRequestEntity entity,
  ) {
    return ForgetPasswordRequestDto(email: entity.email);
  }
}
