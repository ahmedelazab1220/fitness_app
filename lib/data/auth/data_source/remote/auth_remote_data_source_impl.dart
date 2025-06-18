import 'package:fitness_app/data/auth/api/auth_retrofit_client.dart';
import 'package:fitness_app/data/auth/models/request/register_request_dto.dart';
import 'package:fitness_app/data/auth/models/response/register_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../contract/auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRetrofitClient authRetrofitClient;
  AuthRemoteDataSourceImpl(this.authRetrofitClient);
  @override
  Future<RegisterResponseDto> register(RegisterRequestDto request) async {
    return await authRetrofitClient.register(request);
  }
}
