import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/validator/validator.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/register_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/constants.dart';
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

  final ValueNotifier<String?> genderNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<int?> ageNotifier = ValueNotifier<int?>(null);
  final ValueNotifier<int?> weightNotifier = ValueNotifier<int?>(null);
  final ValueNotifier<int?> heightNotifier = ValueNotifier<int?>(null);
  final ValueNotifier<String?> goalNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<String?> activityNotifier = ValueNotifier<String?>(null);

  List<Widget> pages = [
    const RegisterForm(),
    const GenderSelectionScreen(),
    const AgeSelectionScreen(),
    const WeightSelectionScreen(),
    const HeightSelectionScreen(),
    const GoalSelectionScreen(),
    const ActivitySelectionScreen(),
  ];

  final Map<String, String> goalsMap = {
    LocaleKeys.GainWeight.tr(): Constants.gainWeight,
    LocaleKeys.LoseWeight.tr(): Constants.loseWeight,
    LocaleKeys.GetFitter.tr(): Constants.getFitter,
    LocaleKeys.GainMoreFlexible.tr(): Constants.gainMoreFlexible,
    LocaleKeys.LearnTheBasic.tr(): Constants.learnTheBasic,
  };

  List<String> get goals => goalsMap.keys.toList();

  final Map<String, String> activityLevelMap = {
    LocaleKeys.Rookie.tr(): Constants.rookieLevel,
    LocaleKeys.Beginner.tr(): Constants.beginnerLevel,
    LocaleKeys.Intermediate.tr(): Constants.intermediateLevel,
    LocaleKeys.Advanced.tr(): Constants.advancedLevel,
    LocaleKeys.TrueBeast.tr(): Constants.trueBeastLevel,
  };

  List<String> get activityLevels => activityLevelMap.keys.toList();

  void doIntent(RegisterAction action) {
    switch (action) {
      case UserRegistrationAction():
        _register();
      case NextStepAction():
        _nextStep();
      case PreviousStepAction():
        _previousStep();
      case ChangeStepAction():
        _changeStep(action.stepIndex);
    }
  }

  void _nextStep() {
    if (state.stepIndex < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _changeStep(state.stepIndex + 1);
    }
  }

  void _previousStep() {
    if (state.stepIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _changeStep(state.stepIndex - 1);
    }
  }

  void _changeStep(int stepIndex) {
    emit(state.copyWith(stepIndex: stepIndex));
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
        gender: genderNotifier.value,
        age: ageNotifier.value,
        weight: weightNotifier.value,
        height: heightNotifier.value,
        goal: goalsMap[goalNotifier.value],
        activityLevel: activityLevelMap[activityNotifier.value],
      );
      final result = await _registerUseCase((request));

      switch (result) {
        case SuccessResult<RegisterResponseDto>():
          emit(
            state.copyWith(
              registerState: BaseSuccessState<RegisterResponseDto>(
                data: result.data,
              ),
            ),
          );
        case FailureResult<RegisterResponseDto>():
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
