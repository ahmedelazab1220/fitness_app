import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/auth/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SelectLanguageUseCase {
  final AuthRepo _authRepo;

  SelectLanguageUseCase(this._authRepo);

  Future<Result<void>> call(String languageCode) async {
    return await _authRepo.selectLanguage(languageCode);
  }
}
