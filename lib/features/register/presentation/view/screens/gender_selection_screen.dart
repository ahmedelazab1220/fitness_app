import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/core/utils/shared_widgets/shared_auth_layout.dart';
import 'package:fitness_app/core/utils/shared_widgets/shared_blured_container.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/selected_gender_widget.dart';
import 'package:fitness_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectionScreen extends StatelessWidget {
  const GenderSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterCubit>();
    return SharedAuthLayout(
      title: LocaleKeys.TellUsAboutYourself.tr(),
      subtitle: LocaleKeys.WeNeedToKnowYourGender.tr(),
      showIndicator: true,
      currentStep: viewModel.state.stepIndex,
      totalSteps: viewModel.pages.length - 1,
      backButtonAction: () => viewModel.doIntent(PreviousStepAction()),
      child: SharedBluredContainer(
        child: ValueListenableBuilder<String?>(
          valueListenable: viewModel.genderNotifier,
          builder: (BuildContext context, String? value, Widget? child) {
            return SelectedGenderWidget(
              selectedGender: value,
              onSelectGender: (value) => viewModel.genderNotifier.value = value,
              onNext: () => viewModel.doIntent(NextStepAction()),
            );
          },
        ),
      ),
    );
  }
}
