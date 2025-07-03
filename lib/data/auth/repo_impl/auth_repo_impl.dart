import 'package:fitness_app/core/utils/datasource_excution/api_manager.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_local_data_source.dart';
import 'package:fitness_app/data/auth/data_source/contract/auth_remote_data_source.dart';
import 'package:fitness_app/domain/auth/entity/user_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/auth/repo/auth_repo.dart';

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
}
