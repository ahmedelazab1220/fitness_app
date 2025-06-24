import 'package:injectable/injectable.dart';

import '../../api/meals_retrofit_client.dart';
import '../../model/meal_details_response_dto.dart';
import '../contract/meal_details_remote_data_source.dart';

@Injectable(as: MealsRemoteDataSource)
class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final MealsRetrofitClient _client;

  MealsRemoteDataSourceImpl(this._client);

  @override
  Future<MealDetailsResponseDto> getMealDetails(String id) {
    return _client.getMealDetails(id);
  }
}
