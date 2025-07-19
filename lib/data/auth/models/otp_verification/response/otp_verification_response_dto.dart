import 'package:json_annotation/json_annotation.dart';

import '../../../../../domain/auth/entity/otp_verification/response/otp_verification_response_entity.dart';

part 'otp_verification_response_dto.g.dart';

@JsonSerializable()
class OtpVerificationResponseDto {
  final String? error;
  final String? status;

  OtpVerificationResponseDto({this.error, this.status});

  factory OtpVerificationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerificationResponseDtoToJson(this);

  OtpVerificationResponseEntity toEntity() {
    return OtpVerificationResponseEntity(error: error, status: status);
  }
}
