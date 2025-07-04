import 'package:injectable/injectable.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/auth/entity/forget_password/forget_password_request_entity.dart';
import '../../../domain/auth/entity/forget_password/forget_password_response_entity.dart';
import '../../../domain/auth/entity/login/login_request_entity.dart';
import '../../../domain/auth/entity/otp_verification/request/otp_verification_request_entity.dart';
import '../../../domain/auth/entity/otp_verification/response/otp_verification_response_entity.dart';
import '../../../domain/auth/entity/reset_password/request/reset_password_request_entity.dart';
import '../../../domain/auth/entity/reset_password/response/reset_password_response_entity.dart';
import '../../../domain/auth/repo/auth_repo.dart';
import '../data_source/contract/auth_local_data_source.dart';
import '../data_source/contract/auth_remote_data_source.dart';
import '../models/forget_password/request/forget_password_request_dto.dart';
import '../models/login/login_request_dto.dart';
import '../models/otp_verification/request/otp_verification_request_dto.dart';
import '../models/reset_password/request/reset_password_request_dto.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final ApiManager _apiManager;
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepoImpl(
    this._authRemoteDataSource,
    this._authLocalDataSource,
    this._apiManager,
  );

  @override
  Future<Result<void>> login(LoginRequestEntity request) {
    var response = _apiManager.execute(() async {
      final response = await _authRemoteDataSource.login(
        LoginRequestDto.fromDomain(request),
      );
      await _authLocalDataSource.saveToken(
        Constants.token,
        response.token ?? "",
      );
      if (response.user != null) {
        await _authLocalDataSource.saveUser(response.user!);
      }
      return response;
    });
    return response;
  }

  @override
  Future<Result<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) {
    var response = _apiManager.execute<ForgetPasswordResponseEntity>(() async {
      var response = await _authRemoteDataSource.forgetPassword(
        ForgetPasswordRequestDto.fromDomain(request),
      );
      return response.toEntity();
    });
    return response;
  }

  @override
  Future<Result<OtpVerificationResponseEntity>> verifyOtp(
    OtpVerificationRequestEntity request,
  ) {
    var response = _apiManager.execute<OtpVerificationResponseEntity>(() async {
      var response = await _authRemoteDataSource.verifyOtp(
        OtpVerificationRequestDto.fromDomain(request),
      );
      return response.toEntity();
    });
    return response;
  }

  @override
  Future<Result<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) {
    var response = _apiManager.execute<ResetPasswordResponseEntity>(() async {
      var response = await _authRemoteDataSource.resetPassword(
        ResetPasswordRequestDto.fromDomain(request),
      );
      await _authLocalDataSource.saveToken(Constants.token, response.token!);
      return response.toEntity();
    });
    return response;
  }
}
