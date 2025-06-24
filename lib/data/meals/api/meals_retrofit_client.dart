import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';
import '../model/meal_details_response_dto.dart';

part 'meals_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.mealsBaseUrl)
abstract class MealsRetrofitClient {
  @factoryMethod
  factory MealsRetrofitClient(Dio dio, {String baseUrl}) = _MealsRetrofitClient;

  @GET(ApiConstants.mealDetails)
  Future<MealDetailsResponseDto> getMealDetails(@Query("i") String id);
}
