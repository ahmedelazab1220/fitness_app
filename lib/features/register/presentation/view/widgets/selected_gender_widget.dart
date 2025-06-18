import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/selected_gender_card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/register_cubit.dart';

class SelectedGenderWidget extends StatelessWidget {
  const SelectedGenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final cubit = context.read<RegisterCubit>();
        final selected = state.gender;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectedGenderCardItemWidget(
              text: LocaleKeys.Male.tr(),
              isSelected: selected == 'male',
              onTap: () => cubit.setGender('male'),
              iconData: Icons.male,
            ),
            const SizedBox(height: 16.0),
            SelectedGenderCardItemWidget(
              text: LocaleKeys.Female.tr(),
              isSelected: selected == 'female',
              onTap: () => cubit.setGender('female'),
              iconData: Icons.female,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: selected != null ? () => cubit.nextStep() : null,
              child: Text(LocaleKeys.Next.tr()),
            ),
          ],
        );
      },
    );
  }
}
