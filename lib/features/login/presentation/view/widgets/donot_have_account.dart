import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';

class DonotHaveAccount extends StatelessWidget {
  const DonotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.DonotHaveAnAccountYet.tr(),
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColors.white),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            // Navigate to login screen
          },
          child: Text(
            LocaleKeys.Register.tr(),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: AppColors.orange),
          ),
        ),
      ],
    );
  }
}
