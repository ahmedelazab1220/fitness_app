import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/register/register_request_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class RegisterUseCase {
  final AuthRepo _authRepo;
  RegisterUseCase(this._authRepo);

  Future<Result<void>> call(RegisterRequestEntity request) async {
    return await _authRepo.register(request);
  }
}
