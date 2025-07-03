import 'package:fitness_app/data/auth/api/auth_retrofit_client.dart';
import 'package:fitness_app/data/auth/models/logout_response_dto.dart';
import 'package:fitness_app/data/auth/models/user_data_response_dto.dart';
import 'package:injectable/injectable.dart';

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
}
