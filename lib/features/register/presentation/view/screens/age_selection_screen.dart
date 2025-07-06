import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/shared_widgets/shared_auth_layout.dart';
import '../../../../../core/utils/shared_widgets/shared_blured_container.dart';
import '../widgets/wheel_slider_selector.dart';

class AgeSelectionScreen extends StatelessWidget {
  const AgeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterCubit>();
    return SharedAuthLayout(
      title: LocaleKeys.HowOldAreYou.tr(),
      subtitle: LocaleKeys.ThisHelpsUsCreateYourPersonalizedPlan.tr(),
      showIndicator: true,
      currentStep: viewModel.state.stepIndex,
      totalSteps: viewModel.pages.length - 1,
      backButtonAction: () => viewModel.doIntent(PreviousStepAction()),
      child: SharedBluredContainer(
        child: ValueListenableBuilder<int?>(
          valueListenable: viewModel.ageNotifier,
          builder: (BuildContext context, int? value, Widget? child) {
            return WheelSliderSelector(
              label: LocaleKeys.Year.tr(),
              initialValue: value ?? 25,
              onValueChanged: (value) => viewModel.ageNotifier.value = value,
              buttonText: LocaleKeys.Done.tr(),
              onButtonPressed: () => viewModel.doIntent(NextStepAction()),
            );
          },
        ),
      ),
    );
  }
}
