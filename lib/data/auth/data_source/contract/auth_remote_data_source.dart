import 'package:fitness_app/data/auth/models/response/register_response_dto.dart';

import '../../models/request/register_request_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<RegisterResponseDto> register(RegisterRequestDto request);
}
