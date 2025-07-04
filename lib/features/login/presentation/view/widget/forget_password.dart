import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/routes/app_routes.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        clipBehavior: Clip.none,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.forgetPasswordRoute);
        },
        child: Text(
          LocaleKeys.ForgotPassword.tr(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.orange,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.orange,
          ),
        ),
      ),
    );
  }
}
