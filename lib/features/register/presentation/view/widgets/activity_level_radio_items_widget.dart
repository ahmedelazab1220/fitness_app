import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/radio_tile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/register_cubit.dart';

class ActivityLevelRadioItemsWidget extends StatelessWidget {
  const ActivityLevelRadioItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();
        final activityLevels = cubit.activityLevels;
        final selected = state.activity;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...activityLevels.map(
              (activityLevel) => RadioTileItem(
                value: activityLevel,
                selectedValue: selected ?? '',
                onSelected: () => cubit.setActivity(activityLevel),
                onChanged: (value) => cubit.setActivity(value),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: selected != null
                  ? () => cubit.doIntent(UserRegistrationAction())
                  : null,
              child: Text(LocaleKeys.Register.tr()),
            ),
          ],
        );
      },
    );
  }
}
