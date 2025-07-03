import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';

final class ProfileState extends Equatable {
  final BaseState profileState;
  final BaseState logoutState;

  const ProfileState({required this.profileState, required this.logoutState});

  ProfileState copyWith({BaseState? profileState, BaseState? logoutState}) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
      logoutState: logoutState ?? this.logoutState,
    );
  }

  @override
  List<Object?> get props => [profileState, logoutState];
}

sealed class ProfileAction {}

final class GetProfileAction extends ProfileAction {}

final class LogoutAction extends ProfileAction {}

final class SelectLanguageAction extends ProfileAction {
  final String languageCode;

  SelectLanguageAction(this.languageCode);
}
