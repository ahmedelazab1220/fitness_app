import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_remote_data_source.dart';
import 'package:fitness_app/domain/auth/entity/user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/auth/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final ApiManager _apiManager;
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._apiManager, this._authRemoteDataSource);

  @override
  Future<Result<UserEntity>> getProfileData() async {
    final result = await _apiManager.execute<UserEntity>(() async {
      final response = await _authRemoteDataSource.getProfileData();
      return response.user!.toEntity();
    });
    return result;
  }
}
