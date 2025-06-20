import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';
import '../models/forget_password/request/forget_password_request_dto.dart';
import '../models/forget_password/response/forget_password_response_dto.dart';
import '../models/otp_verification/request/otp_verification_request_dto.dart';
import '../models/otp_verification/response/otp_verification_response_dto.dart';
import '../models/reset_password/request/reset_password_request_dto.dart';
import '../models/reset_password/response/reset_password_response_dto.dart';

part 'auth_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @POST(ApiConstants.forgetPasswordRoute)
  Future<ForgetPasswordResponseDto> forgetPassword(
    @Body() ForgetPasswordRequestDto request,
  );

  @POST(ApiConstants.verifyRestCodeRoute)
  Future<OtpVerificationResponseDto> verifyOtp(
    @Body() OtpVerificationRequestDto request,
  );

  @PUT(ApiConstants.resetPasswordRoute)
  Future<ResetPasswordResponseDto> resetPassword(
    @Body() ResetPasswordRequestDto request,
  );
}
