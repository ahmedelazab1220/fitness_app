import 'package:dio/dio.dart';
import 'package:fitness_app/data/auth/models/logout_response_dto.dart';
import 'package:fitness_app/data/auth/models/user_data_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/datasource_excution/api_constants.dart';

part 'auth_retrofit_client.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthRetrofitClient {
  @factoryMethod
  factory AuthRetrofitClient(Dio dio) = _AuthRetrofitClient;

  @GET(ApiConstants.logoutRoute)
  Future<LogoutResponseDto> logout();

  @GET(ApiConstants.profileDataRoute)
  Future<UserDataResponseDto> getProfileData();
}
