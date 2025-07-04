import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/category_entity.dart';
import '../repo/home_repo.dart';

@injectable
class GetExerciseCategoriesUseCase {
  final HomeRepo _homeRepo;

  GetExerciseCategoriesUseCase(this._homeRepo);

  Future<Result<List<CategoryEntity>>> call() async =>
      await _homeRepo.getExerciseCategories();
}
