import 'package:fitness_app/data/meals/data_source/contract/meals_remote_data_source.dart';
import 'package:fitness_app/data/meals/models/categories_response_dto.dart';
import 'package:fitness_app/data/meals/models/meals_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../api/meals_retrofit_client.dart';

@Injectable(as: MealsRemoteDataSource)
class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final MealsRetrofitClient _mealsRetrofitClient;

  MealsRemoteDataSourceImpl(this._mealsRetrofitClient);

  @override
  Future<CategoriesResponseDto> getCategories() async {
    return await _mealsRetrofitClient.getCategories();
  }

  @override
  Future<MealsResponseDto> getMealsByCategory({
    required String category,
  }) async {
    return await _mealsRetrofitClient.getMealsByCategory(category: category);
  }
}
