import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_local_data_source.dart';
import 'package:fitness_app/data/auth/models/request/login_request_dto.dart';
import 'package:fitness_app/data/auth/models/response/login_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/constants.dart';
import '../../../domain/auth/repo/auth_repo.dart';
import '../data_source/contract/auth_remote_data_source.dart';

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
  Future<Result<LoginResponseDto>> login(LoginRequestDto request) async {
    var response = await _apiManager.execute<LoginResponseDto>(() async {
      var response = await _authRemoteDataSource.login(request);
      _authLocalDataSource.saveToken(Constants.token, response.token ?? "");
      return response;
    });
    return response;
  }
}
