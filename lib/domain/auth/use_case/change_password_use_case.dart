import 'package:fitness_app/domain/auth/entity/change_password/request/change_password_request_entity.dart';
import 'package:fitness_app/domain/auth/entity/change_password/response/change_password_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../repo/auth_repo.dart';

@injectable
class ChangePasswordUseCase {
  final AuthRepo _authRepo;

  ChangePasswordUseCase(this._authRepo);

  Future<Result<ChangePasswordResponseEntity>> call(
    ChangePasswordRequestEntity request,
  ) async {
    return await _authRepo.changePassword(request);
  }
}
