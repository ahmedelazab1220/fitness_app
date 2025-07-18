import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/routes/app_routes.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "${LocaleKeys.AlreadyHaveAnAccount.tr()} ",
        style: const TextStyle(color: AppColors.white),
        children: [
          TextSpan(
            text: LocaleKeys.Login.tr(),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
              },
            style: const TextStyle(
              color: AppColors.orange,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.orange,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
