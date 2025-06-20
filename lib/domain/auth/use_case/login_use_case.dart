import 'package:injectable/injectable.dart';

import '../../../../core/utils/datasource_excution/api_result.dart';
import '../entity/login_request_entity.dart';
import '../repo/auth_repo.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:injectable/injectable.dart';

import '../../../data/auth/models/request/login_request_dto.dart';
import '../../../data/auth/models/response/login_response_dto.dart';
import '../repo/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepo _authRep;

  LoginUseCase(this._authRep);

  Future<Result<void>> call(LoginRequest request) async {
    return await _authRep.login(request);
  }
}
@injectable
class LoginUseCase {
  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<Result<LoginResponseDto>> call(LoginRequestDto request) async {
    return await _authRepo.login(request);
  }
}
