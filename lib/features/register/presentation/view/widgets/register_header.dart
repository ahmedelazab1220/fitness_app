import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 46),
            child: Image.asset(AppImages.appLogo, width: 140, height: 100),
          ),
        ),
        const SizedBox(height: 34),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.HeyThere.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              Text(
                LocaleKeys.CreateAnAccount.tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
