import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/datasource_excution/api_result.dart';
import 'package:fitness_app/domain/auth/entity/user_entity.dart';
import 'package:fitness_app/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/auth/use_case/get_profile_data_use_case.dart';
import '../../../../domain/auth/use_case/logout_use_case.dart';
import '../../../../domain/auth/use_case/select_language_use_case.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileDataUseCase _getProfileDataUseCase;
  final LogoutUseCase _logoutUseCase;
  final SelectLanguageUseCase _selectLanguageUseCase;

  ProfileCubit(
    this._getProfileDataUseCase,
    this._logoutUseCase,
    this._selectLanguageUseCase,
  ) : super(
        (ProfileState(
          profileState: BaseInitialState(),
          logoutState: BaseInitialState(),
        )),
      );

  void doIntent(ProfileAction action) {
    switch (action) {
      case GetProfileAction():
        _getProfile();
      case LogoutAction():
        _logout();
      case SelectLanguageAction():
        _selectLanguage(action.languageCode);
    }
  }

  Future<void> _getProfile() async {
    emit(state.copyWith(profileState: BaseLoadingState()));
    final result = await _getProfileDataUseCase.call();
    switch (result) {
      case SuccessResult<UserEntity>():
        emit(state.copyWith(profileState: BaseSuccessState(data: result.data)));
      case FailureResult<UserEntity>():
        emit(
          state.copyWith(
            profileState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutState: BaseLoadingState()));
    final result = await _logoutUseCase.call();
    switch (result) {
      case SuccessResult<void>():
        emit(state.copyWith(logoutState: BaseSuccessState()));
      case FailureResult<void>():
        emit(
          state.copyWith(
            logoutState: BaseErrorState(
              errorMessage: result.exception.toString(),
            ),
          ),
        );
    }
  }

  Future<void> _selectLanguage(String languageCode) async {
    await _selectLanguageUseCase.call(languageCode);
  }
}
