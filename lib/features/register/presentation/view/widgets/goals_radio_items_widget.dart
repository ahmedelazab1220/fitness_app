import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/radio_tile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/register_cubit.dart';

class GoalsRadioItemsWidget extends StatelessWidget {
  const GoalsRadioItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();
        final goals = cubit.goals;
        final selected = state.goal;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...goals.map(
              (goal) => RadioTileItem(
                value: goal,
                selectedValue: selected ?? '',
                onSelected: () => cubit.setGoal(goal),
                onChanged: (value) => cubit.setGoal(value),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: selected != null ? () => cubit.nextStep() : null,
              child: Text(LocaleKeys.Register.tr()),
            ),
          ],
        );
      },
    );
  }
}
