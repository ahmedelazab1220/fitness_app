import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';

class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      Navigator.pushReplacementNamed(context, AppRoutes.registerRoute);
      },
      child: Text.rich(
        TextSpan(
          text: "${LocaleKeys.DonotHaveAnAccountYet.tr()} ",
          style: const TextStyle(color: AppColors.white),
          children: [
            TextSpan(
              text: LocaleKeys.Register.tr(),
              style: const TextStyle(
                color: AppColors.orange,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
