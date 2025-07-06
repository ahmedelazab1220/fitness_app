import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.AlreadyHaveAnAccount.tr(),
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColors.white),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
          },
          child: Text(
            LocaleKeys.Login.tr(),
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: AppColors.orange),
          ),
        ),
      ],
    );
  }
}
