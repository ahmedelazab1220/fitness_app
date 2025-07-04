import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_local_data_source.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_remote_data_source.dart';
import 'package:fitness_app/domain/auth/entity/user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/constants.dart';
import '../../../domain/auth/entity/forget_password/forget_password_request_entity.dart';
import '../../../domain/auth/entity/forget_password/forget_password_response_entity.dart';
import '../../../domain/auth/entity/otp_verification/request/otp_verification_request_entity.dart';
import '../../../domain/auth/entity/otp_verification/response/otp_verification_response_entity.dart';
import '../../../domain/auth/entity/reset_password/request/reset_password_request_entity.dart';
import '../../../domain/auth/entity/reset_password/response/reset_password_response_entity.dart';
import '../../../domain/auth/repo/auth_repo.dart';
import '../models/forget_password/request/forget_password_request_dto.dart';
import '../models/otp_verification/request/otp_verification_request_dto.dart';
import '../models/reset_password/request/reset_password_request_dto.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final ApiManager _apiManager;
  final AuthLocalDataSource _authLocalDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(
    this._apiManager,
    this._authLocalDataSource,
    this._authRemoteDataSource,
  );

  @override
  Future<Result<UserEntity>> getProfileData() async {
    final result = await _apiManager.execute<UserEntity>(() async {
      final response = await _authRemoteDataSource.getProfileData();
      return response.user!.toEntity();
    });
    return result;
  }

  @override
  Future<Result<void>> logout() async {
    final result = await _apiManager.execute<void>(() async {
      await _authRemoteDataSource.logout();
      await _authLocalDataSource.clearAll();
    });
    return result;
  }

  @override
  Future<Result<void>> selectLanguage(String languageCode) async {
    final result = await _apiManager.execute<bool>(() async {
      final response = await _authLocalDataSource.selectLanguage(languageCode);
      return response;
    });
    return result;
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
