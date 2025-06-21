import 'package:injectable/injectable.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/auth/entity/login_request_entity.dart';
import '../../../domain/auth/repo/auth_repo.dart';
import '../data_source/contract/auth_local_data_source.dart';
import '../data_source/contract/auth_remote_data_source.dart';
import '../models/login_request_dto.dart';
import '../models/login_response_dto.dart';

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
  Future<Result<LoginResponseDto>> login(LoginRequest request) {
    var response = _apiManager.execute<LoginResponseDto>(() async {
      final response = await _authRemoteDataSource.login(
        LoginRequestDto(email: request.email, password: request.password),
      );
      _authLocalDataSource.saveToken(Constants.token, response.token ?? "");
      return response;
    });
    return response;
  }
}
