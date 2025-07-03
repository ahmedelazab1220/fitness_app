import '../../models/category_dto.dart';

abstract class HomeLocalDataSource {
  Future<List<CategoryDto>> getExerciseCategories();
}
