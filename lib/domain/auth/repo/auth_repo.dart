import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/login/login_request_entity.dart';

import '../entity/forget_password/forget_password_request_entity.dart';
import '../entity/forget_password/forget_password_response_entity.dart';
import '../entity/otp_verification/request/otp_verification_request_entity.dart';
import '../entity/otp_verification/response/otp_verification_response_entity.dart';
import '../entity/reset_password/request/reset_password_request_entity.dart';
import '../entity/reset_password/response/reset_password_response_entity.dart';

abstract interface class AuthRepo {
  Future<Result<void>> login(LoginRequestEntity request);

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
