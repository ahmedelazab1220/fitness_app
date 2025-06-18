import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_remote_data_source.dart';
import 'package:fitness_app/data/auth/models/request/register_request_dto.dart';
import 'package:fitness_app/data/auth/models/response/register_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../domain/auth/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ApiManager _apiManager;
  AuthRepoImpl(this._authRemoteDataSource, this._apiManager);
  @override
  Future<Result<RegisterResponseDto>> register(
    RegisterRequestDto request,
  ) async {
    return await _apiManager.execute(() async {
      return await _authRemoteDataSource.register(request);
    });
  }
}
