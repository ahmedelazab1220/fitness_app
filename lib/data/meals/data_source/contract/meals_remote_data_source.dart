import 'package:fitness_app/data/meals/models/meals_response_dto.dart';

import '../../models/categories_response_dto.dart';

abstract class MealsRemoteDataSource {
  Future<CategoriesResponseDto> getCategories();

  Future<MealsResponseDto> getMealsByCategory({required String category});
}
