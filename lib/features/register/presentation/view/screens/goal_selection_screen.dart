import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/blured_container.dart';
import '../../view_model/cubit/register_cubit.dart';
import '../widgets/radio_items_widget.dart';

class GoalSelectionScreen extends StatelessWidget {
  const GoalSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Texts with horizontal padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.whatIsYourGoal.tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                LocaleKeys.ThisHelpsUsCreateYourPersonalizedPlan.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        BluredContainer(
          child: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final cubit = context.read<RegisterCubit>();
              return RadioItemsWidget(
                options: cubit.goals,
                selectedValue: state.goal,
                onChanged: cubit.setGoal,
                onSubmit: () => cubit.nextStep(),
                buttonLabel: LocaleKeys.Register.tr(),
              );
            },
          ),
        ),
      ],
    );
  }
}
