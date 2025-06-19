import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:injectable/injectable.dart';

import '../../../data/auth/models/request/login_request_dto.dart';
import '../../../data/auth/models/response/login_response_dto.dart';
import '../repo/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<Result<LoginResponseDto>> call(LoginRequestDto request) async {
    return await _authRepo.login(request);
  }
}
