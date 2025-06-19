import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/assets/app_images.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import 'reset_password_form.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundTwo),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50.0),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.orange,
                        radius: 14,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            size: 28,
                            Icons.arrow_left_rounded,
                            color: AppColors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Spacer(),
                      Image.asset(AppImages.appLogoImage),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 60.0),
                  Text(
                    LocaleKeys.MakeSureIts8CharacterOrMore.tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    LocaleKeys.CreateNewPassword.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          const ResetPasswordForm(),
        ],
      ),
    );
  }
}
