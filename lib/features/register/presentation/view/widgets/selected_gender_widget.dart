import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/selected_gender_card_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SelectedGenderCardItemWidget(
          text: LocaleKeys.Male.tr(),
          isSelected: selectedGender == 'male',
          onTap: () => onSelectGender('male'),
          iconData: Icons.male,
        ),
        const SizedBox(height: 16.0),
        SelectedGenderCardItemWidget(
          text: LocaleKeys.Female.tr(),
          isSelected: selectedGender == 'female',
          onTap: () => onSelectGender('female'),
          iconData: Icons.female,
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: selectedGender != null ? onNext : null,
          child: Text(LocaleKeys.Next.tr()),
        ),
      ],
    );
  }
}
