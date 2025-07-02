import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/radio_items_widget.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/step_widget.dart';
import 'package:fitness_app/features/register/presentation/view_model/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';

class ActivitySelectionScreen extends StatelessWidget {
  const ActivitySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StepWidget(
      title: LocaleKeys.YourRegularPhysicalActivityLevel.tr(),
      subtitle: LocaleKeys.ThisHelpsUsCreateYourPersonalizedPlan.tr(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          final viewModel = context.read<RegisterCubit>();
          return RadioItemsWidget(
            options: viewModel.activityLevels,
            selectedValue: state.activity,
            onChanged: (value) => viewModel.doIntent(SetActivityAction(value)),
            onSubmit: () => viewModel.doIntent(UserRegistrationAction()),
            buttonLabel: LocaleKeys.Register.tr(),
          );
        },
      ),
    );
  }
}
