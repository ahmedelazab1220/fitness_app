import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';

import '../../../data/auth/models/request/register_request_dto.dart';
import '../../../data/auth/models/response/register_response_dto.dart';

abstract interface class AuthRepo {
  Future<Result<RegisterResponseDto>> register(RegisterRequestDto request);
}
