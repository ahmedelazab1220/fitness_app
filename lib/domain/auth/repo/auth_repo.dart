import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/auth/entity/user_entity.dart';
import '../entity/forget_password/forget_password_request_entity.dart';
import '../entity/forget_password/forget_password_response_entity.dart';
import '../entity/otp_verification/request/otp_verification_request_entity.dart';
import '../entity/otp_verification/response/otp_verification_response_entity.dart';
import '../entity/reset_password/request/reset_password_request_entity.dart';
import '../entity/reset_password/response/reset_password_response_entity.dart';

abstract class AuthRepo {
  Future<Result<UserEntity>> getProfileData();

  Future<Result<void>> logout();

  Future<Result<void>> selectLanguage(String languageCode);

  Future<Result<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  );

  Future<Result<OtpVerificationResponseEntity>> verifyOtp(
    OtpVerificationRequestEntity request,
  );

  Future<Result<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  );
}
