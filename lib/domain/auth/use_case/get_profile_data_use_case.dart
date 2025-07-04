import 'package:fitness_app/domain/auth/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/user_entity.dart';

@injectable
class GetProfileDataUseCase {
  final AuthRepo _authRepo;

  GetProfileDataUseCase(this._authRepo);

  Future<Result<UserEntity>> call() async {
    return await _authRepo.getProfileData();
  }
}
