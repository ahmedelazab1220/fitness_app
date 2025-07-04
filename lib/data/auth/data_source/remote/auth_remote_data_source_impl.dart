import 'package:fitness_app/data/auth/api/auth_retrofit_client.dart';
import 'package:fitness_app/data/auth/models/logout_response_dto.dart';
import 'package:fitness_app/data/auth/models/user_data_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../models/forget_password/request/forget_password_request_dto.dart';
import '../../models/forget_password/response/forget_password_response_dto.dart';
import '../../models/otp_verification/request/otp_verification_request_dto.dart';
import '../../models/otp_verification/response/otp_verification_response_dto.dart';
import '../../models/reset_password/request/reset_password_request_dto.dart';
import '../../models/reset_password/response/reset_password_response_dto.dart';
import '../contract/auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRetrofitClient _authRetrofitClient;

  AuthRemoteDataSourceImpl(this._authRetrofitClient);

  @override
  Future<UserDataResponseDto> getProfileData() async {
    return await _authRetrofitClient.getProfileData();
  }

  @override
  Future<LogoutResponseDto> logout() async {
    return await _authRetrofitClient.logout();
  }

  @override
  Future<ForgetPasswordResponseDto> forgetPassword(
    ForgetPasswordRequestDto request,
  ) async {
    var response = await _authRetrofitClient.forgetPassword(request);
    return response;
  }

  @override
  Future<OtpVerificationResponseDto> verifyOtp(
    OtpVerificationRequestDto request,
  ) async {
    var response = await _authRetrofitClient.verifyOtp(request);
    return response;
  }

  @override
  Future<ResetPasswordResponseDto> resetPassword(
    ResetPasswordRequestDto request,
  ) async {
    var response = await _authRetrofitClient.resetPassword(request);
    return response;
  }
}
