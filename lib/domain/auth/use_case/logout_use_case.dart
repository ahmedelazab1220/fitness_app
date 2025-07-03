import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/auth/repo/auth_repo.dart';

class LogoutUseCase {
  final AuthRepo _authRepo;

  LogoutUseCase(this._authRepo);

  Future<Result<void>> call() async {
    return await _authRepo.logout();
  }
}
