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
import '../../../data/workouts/api/workouts_retrofit_client.dart' as _i578;
import '../../../data/workouts/data_source/contract/workouts_remote_data_source.dart'
    as _i708;
import '../../../data/workouts/data_source/remote/workouts_remote_data_source_impl.dart'
    as _i167;
import '../../../data/workouts/repo_impl/workouts_repo_impl.dart' as _i287;
import '../../../domain/auth/repo/auth_repo.dart' as _i1047;
import '../../../domain/workouts/repo/workouts_repo.dart' as _i263;
import '../../../domain/workouts/use_case/get_all_muscle_groups_use_case.dart'
    as _i522;
import '../../../domain/workouts/use_case/get_all_muscles_by_muscle_group_use_case.dart'
    as _i546;
import '../../../features/workouts/presentation/view_model/workouts_cubit.dart'
    as _i1008;
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
      () => dioModule.provideDio(
        gh<_i460.SharedPreferences>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i1064.AuthRetrofitClient>(
      () => _i1064.AuthRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i578.WorkoutsRetrofitClient>(
      () => _i578.WorkoutsRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i708.WorkoutsRemoteDataSource>(
      () => _i167.WorkoutsRemoteDataSourceImpl(
        gh<_i578.WorkoutsRetrofitClient>(),
      ),
    );
    gh.factory<_i263.WorkoutsRepo>(
      () => _i287.WorkoutsRepoImpl(
        gh<_i708.WorkoutsRemoteDataSource>(),
        gh<_i28.ApiManager>(),
      ),
    );
    gh.factory<_i546.GetAllMusclesByMuscleGroupUseCase>(
      () => _i546.GetAllMusclesByMuscleGroupUseCase(gh<_i263.WorkoutsRepo>()),
    );
    gh.factory<_i522.GetAllMuscleGroupsUseCase>(
      () => _i522.GetAllMuscleGroupsUseCase(gh<_i263.WorkoutsRepo>()),
    );
    gh.factory<_i1008.WorkoutsCubit>(
      () => _i1008.WorkoutsCubit(
        gh<_i522.GetAllMuscleGroupsUseCase>(),
        gh<_i546.GetAllMusclesByMuscleGroupUseCase>(),
      ),
    );
    return this;
  }
}

class _$SharedPreferenceModule extends _i60.SharedPreferenceModule {}

class _$SecureStorageModule extends _i712.SecureStorageModule {}

class _$LoggerModule extends _i470.LoggerModule {}

class _$DioModule extends _i953.DioModule {}
