import 'package:json_annotation/json_annotation.dart';

import '../../../../../domain/auth/entity/forget_password/forget_password_response_entity.dart';

part 'forget_password_response_dto.g.dart';

@JsonSerializable()
class ForgetPasswordResponseDto {
  final String? message;
  final String? info;
  final String? error;

  ForgetPasswordResponseDto({this.message, this.info, this.error});

  factory ForgetPasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseDtoToJson(this);

  ForgetPasswordResponseEntity toEntity() {
    return ForgetPasswordResponseEntity(
      message: message,
      info: info,
      error: error,
    );
  }
}
