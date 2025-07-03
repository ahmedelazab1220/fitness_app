// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../../data/auth/api/auth_retrofit_client.dart' as _i1064;
import '../../../data/auth/data_source/contract/auth_local_data_source.dart'
    as _i1063;
import '../../../data/auth/data_source/contract/auth_remote_data_source.dart'
    as _i774;
import '../../../data/auth/data_source/local/auth_local_data_source_impl.dart'
    as _i757;
import '../../../data/auth/data_source/remote/auth_remote_data_source_impl.dart'
    as _i173;
import '../../../data/auth/repo_impl/auth_repo_impl.dart' as _i15;
import '../../../data/excercise/api/exercise_retrofit_client.dart' as _i253;
import '../../../data/excercise/data_source/contarct/exercise_remote_data_source.dart'
    as _i234;
import '../../../data/excercise/data_source/remote/exercise_remote_data_source_impl.dart'
    as _i696;
import '../../../data/excercise/repo_impl/excercise_repo_impl.dart' as _i500;
import '../../../domain/auth/repo/auth_repo.dart' as _i1047;
import '../../../domain/excercise/repo/excercise_repo.dart' as _i887;
import '../../../domain/excercise/use_case/get_difficulty_levels_by_muscle_id_use_case.dart'
    as _i83;
import '../../../domain/excercise/use_case/get_exercises_details_use_case.dart'
    as _i246;
import '../../../features/excercise/view_model/cubit/excercise_cubit.dart'
    as _i1056;
import '../../functions/inital_route_function.dart' as _i420;
import '../bloc_observer/bloc_observer_service.dart' as _i649;
import '../datasource_excution/api_manager.dart' as _i28;
import '../datasource_excution/dio_module.dart' as _i953;
import '../flutter_secure_storage_module.dart' as _i712;
import '../logging/logger_module.dart' as _i470;
import '../shared_preference_module.dart' as _i60;
import '../validator/validator.dart' as _i468;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferenceModule = _$SharedPreferenceModule();
    final secureStorageModule = _$SecureStorageModule();
    final loggerModule = _$LoggerModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferenceModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i28.ApiManager>(() => _i28.ApiManager());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.storage,
    );
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.lazySingleton<_i468.Validator>(() => _i468.Validator());
    gh.factory<_i1063.AuthLocalDataSource>(
      () => _i757.AuthLocalDataSourceImpl(),
    );
    gh.singleton<_i649.BlocObserverService>(
      () => _i649.BlocObserverService(gh<_i974.Logger>()),
    );
    gh.factory<_i420.RouteInitializer>(
      () => _i420.RouteInitializer(
        flutterSecureStorage: gh<_i558.FlutterSecureStorage>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i1047.AuthRepo>(() => _i15.AuthRepoImpl());
    gh.factory<_i774.AuthRemoteDataSource>(
      () => _i173.AuthRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.provideDio(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i1064.AuthRetrofitClient>(
      () => _i1064.AuthRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i253.ExerciseRetrofitClient>(
      () => _i253.ExerciseRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i234.ExerciseRemoteDataSource>(
      () => _i696.ExerciseRemoteDataSourceImpl(
        gh<_i253.ExerciseRetrofitClient>(),
      ),
    );
    gh.factory<_i887.ExerciseRepo>(
      () => _i500.ExerciseRepoImpl(
        gh<_i234.ExerciseRemoteDataSource>(),
        gh<_i28.ApiManager>(),
      ),
    );
    gh.factory<_i83.GetDifficultyLevelsByMuscleIdUseCase>(
      () => _i83.GetDifficultyLevelsByMuscleIdUseCase(gh<_i887.ExerciseRepo>()),
    );
    gh.factory<_i246.GetExercisesDetailsUseCase>(
      () => _i246.GetExercisesDetailsUseCase(gh<_i887.ExerciseRepo>()),
    );
    gh.factory<_i1056.ExcerciseCubit>(
      () => _i1056.ExcerciseCubit(
        gh<_i83.GetDifficultyLevelsByMuscleIdUseCase>(),
        gh<_i246.GetExercisesDetailsUseCase>(),
      ),
    );
    return this;
  }
}

class _$SharedPreferenceModule extends _i60.SharedPreferenceModule {}

class _$SecureStorageModule extends _i712.SecureStorageModule {}

class _$LoggerModule extends _i470.LoggerModule {}

class _$DioModule extends _i953.DioModule {}
