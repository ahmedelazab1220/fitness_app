import 'package:fitness_app/data/auth/models/logout_response_dto.dart';
import 'package:fitness_app/data/auth/models/user_data_response_dto.dart';
import '../../models/forget_password/request/forget_password_request_dto.dart';
import '../../models/forget_password/response/forget_password_response_dto.dart';
import '../../models/otp_verification/request/otp_verification_request_dto.dart';
import '../../models/otp_verification/response/otp_verification_response_dto.dart';
import '../../models/reset_password/request/reset_password_request_dto.dart';
import '../../models/reset_password/response/reset_password_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<UserDataResponseDto> getProfileData();

  Future<LogoutResponseDto> logout();

  Future<ForgetPasswordResponseDto> forgetPassword(
      ForgetPasswordRequestDto request,
      );

  Future<OtpVerificationResponseDto> verifyOtp(
      OtpVerificationRequestDto request,
      );

  Future<ResetPasswordResponseDto> resetPassword(
      ResetPasswordRequestDto request,
      );
}
