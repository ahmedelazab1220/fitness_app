import 'package:fitness_app/data/auth/models/request/login_request_dto.dart';
import 'package:fitness_app/data/auth/models/response/login_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../api/auth_retrofit_client.dart';
import '../contract/auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRetrofitClient _authRetrofitClient;
  AuthRemoteDataSourceImpl(this._authRetrofitClient);
  @override
  Future<LoginResponseDto> login(LoginRequestDto request) async {
    return await _authRetrofitClient.login(request);
  }
}
