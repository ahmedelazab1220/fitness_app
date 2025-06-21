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
import '../../../data/meals/api/meals_retrofit_client.dart' as _i328;
import '../../../data/meals/data_source/contract/meals_remote_data_source.dart'
    as _i112;
import '../../../data/meals/data_source/remote/meals_remote_data_source_impl.dart'
    as _i107;
import '../../../data/meals/repo_impl/meals_repo_impl.dart' as _i732;
import '../../../domain/auth/repo/auth_repo.dart' as _i1047;
import '../../../domain/meals/repo/meals_repo.dart' as _i1031;
import '../../../domain/meals/use_case/get_categories_use_case.dart' as _i985;
import '../../../domain/meals/use_case/get_meals_by_category_use_case.dart'
    as _i112;
import '../../../features/meals/presentation/view_model/meals_cubit.dart'
    as _i27;
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
    gh.factory<_i328.MealsRetrofitClient>(
      () => _i328.MealsRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i112.MealsRemoteDataSource>(
      () => _i107.MealsRemoteDataSourceImpl(gh<_i328.MealsRetrofitClient>()),
    );
    gh.factory<_i1031.MealsRepo>(
      () => _i732.MealsRepoImpl(
        gh<_i112.MealsRemoteDataSource>(),
        gh<_i28.ApiManager>(),
      ),
    );
    gh.factory<_i985.GetCategoriesUseCase>(
      () => _i985.GetCategoriesUseCase(gh<_i1031.MealsRepo>()),
    );
    gh.factory<_i112.GetMealsByCategoryUseCase>(
      () => _i112.GetMealsByCategoryUseCase(gh<_i1031.MealsRepo>()),
    );
    gh.factory<_i27.MealsCubit>(
      () => _i27.MealsCubit(
        gh<_i985.GetCategoriesUseCase>(),
        gh<_i112.GetMealsByCategoryUseCase>(),
      ),
    );
    return this;
  }
}

class _$SharedPreferenceModule extends _i60.SharedPreferenceModule {}

class _$SecureStorageModule extends _i712.SecureStorageModule {}

class _$LoggerModule extends _i470.LoggerModule {}

class _$DioModule extends _i953.DioModule {}
