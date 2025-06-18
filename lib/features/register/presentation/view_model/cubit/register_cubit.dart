import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/validator/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../data/auth/models/request/register_request_dto.dart';
import '../../../../../data/auth/models/response/register_response_dto.dart';
import '../../../../../domain/auth/use_case/register_use_case.dart';
import '../../view/screens/activity_selection_screen.dart';
import '../../view/screens/age_selection_screen.dart';
import '../../view/screens/gender_selection_screen.dart';
import '../../view/screens/goal_selection_screen.dart';
import '../../view/screens/height_selection_screen.dart';
import '../../view/screens/weight_selection_screen.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  final Validator validator;

  RegisterCubit(this._registerUseCase, this.validator)
    : super(RegisterState(registerState: BaseInitialState()));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final PageController pageController = PageController();
  final List<Widget> pages = [
    const GenderSelectionScreen(),
    const AgeSelectionScreen(),
    const WeightSelectionScreen(),
    const HeightSelectionScreen(),
    const GoalSelectionScreen(),
    const ActivitySelectionScreen(),
  ];

  final Map<String, String> goalsMap = {
    LocaleKeys.GainWeight.tr(): 'Gain Weight',
    LocaleKeys.LoseWeight.tr(): 'Lose Weight',
    LocaleKeys.GetFitter.tr(): 'Get Fitter',
    LocaleKeys.GainMoreFlexible.tr(): 'Gain More Flexible',
    LocaleKeys.LearnTheBasic.tr(): 'Learn The Basic',
  };

  List<String> get goals => goalsMap.keys.toList();

  final Map<String, String> activityLevelMap = {
    LocaleKeys.Rookie.tr(): 'level1',
    LocaleKeys.Beginner.tr(): 'level2',
    LocaleKeys.Intermediate.tr(): 'level3',
    LocaleKeys.Advanced.tr(): 'level4',
    LocaleKeys.TrueBeast.tr(): 'level5',
  };

  List<String> get activityLevels => activityLevelMap.keys.toList();

  void doIntent(RegisterAction action) {
    switch (action) {
      case UserRegistrationAction():
        {
          _register();
        }
    }
  }

  setGender(String g) {
    emit(state.copyWith(gender: g));
  }

  void setAge(int a) {
    emit(state.copyWith(age: a));
  }

  void setWeight(int w) {
    emit(state.copyWith(weight: w));
  }

  void setHeight(int h) {
    emit(state.copyWith(height: h));
  }

  void setGoal(String g) {
    emit(state.copyWith(goal: g));
  }

  void setActivity(String a) {
    emit(state.copyWith(activity: a));
  }

  void nextStep() {
    if (state.stepIndex < pages.length - 1) {
      emit(state.copyWith(stepIndex: state.stepIndex + 1));
      pageController.animateToPage(
        state.stepIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    if (state.stepIndex > 0) {
      emit(state.copyWith(stepIndex: state.stepIndex - 1));
      pageController.animateToPage(
        state.stepIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _register() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(registerState: BaseLoadingState()));
      final request = RegisterRequestDto(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        rePassword: passwordController.text,
        gender: state.gender,
        age: state.age,
        weight: state.weight,
        height: state.height,
        goal: goalsMap[state.goal],
        activityLevel: activityLevelMap[state.activity],
      );
      final result = await _registerUseCase((request));

      switch (result) {
        case SuccessResult<RegisterResponseDto>():
          {
            emit(
              state.copyWith(
                registerState: BaseSuccessState<RegisterResponseDto>(
                  data: result.data,
                ),
              ),
            );
          }
        case FailureResult<RegisterResponseDto>():
          {
            emit(
              state.copyWith(
                registerState: BaseErrorState(
                  errorMessage: result.exception.toString(),
                ),
              ),
            );
          }
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    pageController.dispose();
    return super.close();
  }
}
