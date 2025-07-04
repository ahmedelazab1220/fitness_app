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
import '../../../data/home/api/home_retrofit_client.dart' as _i486;
import '../../../data/home/data_source/contract/home_local_data_source.dart'
    as _i368;
import '../../../data/home/data_source/contract/home_remote_data_source.dart'
    as _i958;
import '../../../data/home/data_source/local/home_local_data_source_impl.dart'
    as _i410;
import '../../../data/home/data_source/remote/home_remote_data_source_impl.dart'
    as _i208;
import '../../../data/home/repo_impl/home_repo_impl.dart' as _i779;
import '../../../domain/auth/repo/auth_repo.dart' as _i1047;
import '../../../domain/auth/use_case/forget_password_use_case.dart' as _i728;
import '../../../domain/auth/use_case/login_use_case.dart' as _i872;
import '../../../domain/auth/use_case/otp_verification_use_case.dart' as _i777;
import '../../../domain/auth/use_case/reset_password_use_case.dart' as _i55;
import '../../../domain/home/repo/home_repo.dart' as _i81;
import '../../../domain/home/use_case/get_all_muscles_use_case.dart' as _i840;
import '../../../domain/home/use_case/get_daily_recommendation_exercise_use_case.dart'
    as _i360;
import '../../../domain/home/use_case/get_exercise_categories_use_case.dart'
    as _i896;
import '../../../domain/home/use_case/get_food_recommendation_use_case.dart'
    as _i910;
import '../../../domain/home/use_case/get_upcoming_workout_use_case.dart'
    as _i819;
import '../../../features/forget_password/presentation/view_model/cubit/forget_password_cubit.dart'
    as _i70;
import '../../../features/home/presentation/view_model/cubit/home_cubit.dart'
    as _i131;
import '../../../features/login/presentation/view_model/cubit/login_cubit.dart'
    as _i199;
import '../../../features/main_layout/presentation/view_model/cubit/main_layout_cubit.dart'
    as _i393;
import '../../../features/onBoarding/presentation/view_model/cubit/on_boarding_cubit.dart'
    as _i485;
import '../../../features/otp_verification/presentation/view_model/cubit/otp_verification_cubit.dart'
    as _i662;
import '../../../features/reset_password/presentation/view_model/cubit/reset_password_cubit.dart'
    as _i893;
import '../../functions/initial_route_function.dart' as _i687;
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
    gh.factory<_i485.OnBoardingCubit>(() => _i485.OnBoardingCubit());
    gh.singleton<_i28.ApiManager>(() => _i28.ApiManager());
    gh.singleton<_i393.MainLayoutCubit>(() => _i393.MainLayoutCubit());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.storage,
    );
    gh.lazySingleton<_i974.Logger>(() => loggerModule.loggerProvider);
    gh.lazySingleton<_i974.PrettyPrinter>(() => loggerModule.prettyPrinter);
    gh.lazySingleton<_i468.Validator>(() => _i468.Validator());
    gh.singleton<_i649.BlocObserverService>(
      () => _i649.BlocObserverService(gh<_i974.Logger>()),
    );
    gh.factory<_i1063.AuthLocalDataSource>(
      () => _i757.AuthLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i687.RouteInitializer>(
      () => _i687.RouteInitializer(
        flutterSecureStorage: gh<_i558.FlutterSecureStorage>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i368.HomeLocalDataSource>(
      () => _i410.HomeLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.provideDio(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i486.HomeRetrofitClient>(
      () => _i486.HomeRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1064.AuthRetrofitClient>(
      () => _i1064.AuthRetrofitClient(gh<_i361.Dio>()),
    );
    gh.factory<_i774.AuthRemoteDataSource>(
      () => _i173.AuthRemoteDataSourceImpl(gh<_i1064.AuthRetrofitClient>()),
    );
    gh.factory<_i1047.AuthRepo>(
      () => _i15.AuthRepoImpl(
        gh<_i774.AuthRemoteDataSource>(),
        gh<_i1063.AuthLocalDataSource>(),
        gh<_i28.ApiManager>(),
      ),
    );
    gh.singleton<_i958.HomeRemoteDataSource>(
      () => _i208.HomeRemoteDataSourceImpl(gh<_i486.HomeRetrofitClient>()),
    );
    gh.factory<_i872.LoginUseCase>(
      () => _i872.LoginUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i728.ForgetPasswordUseCase>(
      () => _i728.ForgetPasswordUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i777.OtpVerificationUseCase>(
      () => _i777.OtpVerificationUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i55.ResetPasswordUseCase>(
      () => _i55.ResetPasswordUseCase(gh<_i1047.AuthRepo>()),
    );
    gh.factory<_i81.HomeRepo>(
      () => _i779.HomeRepoImpl(
        gh<_i958.HomeRemoteDataSource>(),
        gh<_i368.HomeLocalDataSource>(),
        gh<_i28.ApiManager>(),
      ),
    );
    gh.factory<_i199.LoginCubit>(
      () => _i199.LoginCubit(gh<_i872.LoginUseCase>(), gh<_i468.Validator>()),
    );
    gh.factory<_i662.OtpVerificationCubit>(
      () => _i662.OtpVerificationCubit(
        gh<_i777.OtpVerificationUseCase>(),
        gh<_i728.ForgetPasswordUseCase>(),
      ),
    );
    gh.factory<_i893.ResetPasswordCubit>(
      () => _i893.ResetPasswordCubit(
        gh<_i55.ResetPasswordUseCase>(),
        gh<_i468.Validator>(),
      ),
    );
    gh.factory<_i70.ForgetPasswordCubit>(
      () => _i70.ForgetPasswordCubit(
        gh<_i728.ForgetPasswordUseCase>(),
        gh<_i468.Validator>(),
      ),
    );
    gh.factory<_i840.GetAllMusclesUseCase>(
      () => _i840.GetAllMusclesUseCase(gh<_i81.HomeRepo>()),
    );
    gh.factory<_i360.GetDailyRecommendationExerciseUseCase>(
      () => _i360.GetDailyRecommendationExerciseUseCase(gh<_i81.HomeRepo>()),
    );
    gh.factory<_i896.GetExerciseCategoriesUseCase>(
      () => _i896.GetExerciseCategoriesUseCase(gh<_i81.HomeRepo>()),
    );
    gh.factory<_i910.GetFoodRecommendationUseCase>(
      () => _i910.GetFoodRecommendationUseCase(gh<_i81.HomeRepo>()),
    );
    gh.factory<_i819.GetUpcomingWorkoutUseCase>(
      () => _i819.GetUpcomingWorkoutUseCase(gh<_i81.HomeRepo>()),
    );
    gh.factory<_i131.HomeCubit>(
      () => _i131.HomeCubit(
        gh<_i360.GetDailyRecommendationExerciseUseCase>(),
        gh<_i910.GetFoodRecommendationUseCase>(),
        gh<_i819.GetUpcomingWorkoutUseCase>(),
        gh<_i896.GetExerciseCategoriesUseCase>(),
        gh<_i840.GetAllMusclesUseCase>(),
      ),
    );
    return this;
  }
}

class _$SharedPreferenceModule extends _i60.SharedPreferenceModule {}

class _$SecureStorageModule extends _i712.SecureStorageModule {}

class _$LoggerModule extends _i470.LoggerModule {}

class _$DioModule extends _i953.DioModule {}
