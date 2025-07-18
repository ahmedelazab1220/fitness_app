import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/register_cubit.dart';
import 'selected_gender_card_item_widget.dart';

class SelectedGenderWidget extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String> onSelectGender;
  final VoidCallback onNext;

  const SelectedGenderWidget({
    super.key,
    required this.selectedGender,
    required this.onSelectGender,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SelectedGenderCardItemWidget(
          text: LocaleKeys.Male.tr(),
          isSelected: selectedGender == Constants.male,
          onTap: () => onSelectGender(Constants.male),
          iconData: Icons.male,
        ),
        const SizedBox(height: 16.0),
        SelectedGenderCardItemWidget(
          text: LocaleKeys.Female.tr(),
          isSelected: selectedGender == Constants.female,
          onTap: () => onSelectGender(Constants.female),
          iconData: Icons.female,
        ),
        const SizedBox(height: 16.0),
        ValueListenableBuilder(
          valueListenable: viewModel.isValidate,
          builder: (context, value, child) {
            return ElevatedButton(
              onPressed: value && selectedGender != null ? onNext : null,
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                backgroundColor: WidgetStateProperty.all(
                  value && selectedGender != null
                      ? AppColors.orange
                      : AppColors.white[AppColors.colorCode30],
                ),
              ),
              child: Text(LocaleKeys.Next.tr()),
            );
          },
        ),
      ],
    );
  }
}
