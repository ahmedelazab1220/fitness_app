import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';

class ChangePasswordState extends Equatable {
  final BaseState changePasswordState;

  const ChangePasswordState({required this.changePasswordState});

  ChangePasswordState copyWith({BaseState? changePasswordState}) {
    return ChangePasswordState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
    );
  }

  @override
  List<Object?> get props => [changePasswordState];
}

sealed class ChangePasswordAction {}

final class UserChangePasswordAction extends ChangePasswordAction {}
