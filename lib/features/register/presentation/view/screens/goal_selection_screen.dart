import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/shared_auth_layout.dart';
import '../../../../../core/utils/shared_widgets/shared_blured_container.dart';
import '../../view_model/cubit/register_cubit.dart';
import '../widgets/radio_items_widget.dart';

class GoalSelectionScreen extends StatelessWidget {
  const GoalSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterCubit>();
    return SharedAuthLayout(
      title: LocaleKeys.whatIsYourGoal.tr(),
      subtitle: LocaleKeys.ThisHelpsUsCreateYourPersonalizedPlan.tr(),
      showIndicator: true,
      currentStep: viewModel.state.stepIndex,
      totalSteps: viewModel.pages.length - 1,
      backButtonAction: () => viewModel.doIntent(PreviousStepAction()),
      child: SharedBluredContainer(
        child: ValueListenableBuilder<String?>(
          valueListenable: viewModel.goalNotifier,
          builder: (BuildContext context, String? value, Widget? child) {
            return RadioItemsWidget(
              options: viewModel.goals,
              selectedValue: value,
              onChanged: (value) => viewModel.goalNotifier.value = value,
              onSubmit: () => viewModel.doIntent(NextStepAction()),
              buttonLabel: LocaleKeys.Register.tr(),
            );
          },
        ),
      ),
    );
  }
}
