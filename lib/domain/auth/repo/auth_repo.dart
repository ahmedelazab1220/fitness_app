import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/auth/entity/user_entity.dart';

abstract class AuthRepo {
  Future<Result<UserEntity>> getProfileData();
}
