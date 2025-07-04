import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/meals/entity/category_entity.dart';
import 'package:fitness_app/domain/meals/repo/meals_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  final MealsRepo _mealsRepo;

  GetCategoriesUseCase(this._mealsRepo);

  Future<Result<List<CategoryEntity>>> call() async {
    return await _mealsRepo.getCategories();
  }
}
