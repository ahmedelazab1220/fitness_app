import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/step_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/register_cubit.dart';
import '../widgets/radio_items_widget.dart';

class GoalSelectionScreen extends StatelessWidget {
  const GoalSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StepWidget(
      title: LocaleKeys.whatIsYourGoal.tr(),
      subtitle: LocaleKeys.ThisHelpsUsCreateYourPersonalizedPlan.tr(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          final viewModel = context.read<RegisterCubit>();
          return RadioItemsWidget(
            options: viewModel.goals,
            selectedValue: state.goal,
            onChanged: (value) => viewModel.doIntent(SetGoalAction(value)),
            onSubmit: () => viewModel.doIntent(NextStepAction()),
            buttonLabel: LocaleKeys.Register.tr(),
          );
        },
      ),
    );
  }
}
