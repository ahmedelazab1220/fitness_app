import 'package:dio/dio.dart';
import 'package:fitness_app/data/meals/models/categories_response_dto.dart';
import 'package:fitness_app/data/meals/models/meals_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';

part 'meals_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.mealsBaseUrl)
abstract class MealsRetrofitClient {
  @factoryMethod
  factory MealsRetrofitClient(Dio dio) = _MealsRetrofitClient;

  @GET(ApiConstants.mealsCategories)
  Future<CategoriesResponseDto> getCategories();

  @GET(ApiConstants.filterMealsByCategory)
  Future<MealsResponseDto> getMealsByCategory({
    @Query("c") required String category,
  });
}
