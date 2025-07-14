import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../data/auth/models/request/register_request_dto.dart';
import '../../../data/auth/models/response/register_response_dto.dart';
import '../repo/auth_repo.dart';

@injectable
class RegisterUseCase {
  final AuthRepo _authRepo;
  RegisterUseCase(this._authRepo);

  Future<Result<RegisterResponseDto>> call(RegisterRequestDto request) async {
    return await _authRepo.register(request);
  }
}
