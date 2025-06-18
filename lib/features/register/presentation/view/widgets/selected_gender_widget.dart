import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/selected_gender_card_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';

class SelectedGenderWidget extends StatelessWidget {
  const SelectedGenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          SelectedGenderCardItemWidget(
            text: 'Male',
            onTap: () {},
            iconData: Icons.male,
          ),
          SelectedGenderCardItemWidget(
            text: 'Female',
            onTap: () {},
            iconData: Icons.female,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(LocaleKeys.Next.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
