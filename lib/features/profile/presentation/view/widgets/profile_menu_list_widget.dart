import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/dialogs/app_dialogs.dart';
import 'package:fitness_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/assets/app_icons.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/routes/app_routes.dart';
import '../../view_model/profile_state.dart';
import 'profile_menu_item_widget.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final viewModel = context.read<ProfileCubit>();
        final isLoading = state.profileState is BaseLoadingState;

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            children: [
              ProfileMenuItemWidget(
                icon: AppIcons.profileIcon,
                label: LocaleKeys.EditProfile.tr(),
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.editProfileRoute),
              ),
              ProfileMenuItemWidget(
                icon: AppIcons.changePasswordIcon,
                label: LocaleKeys.ChangePassword.tr(),
                onTap: () {},
              ),
              ProfileMenuItemWidget(
                icon: AppIcons.changeLanguageIcon,
                label:
                    '${LocaleKeys.SelectLanguage.tr()} (${context.locale.languageCode == Constants.en ? LocaleKeys.English.tr() : LocaleKeys.Arabic.tr()})',
                trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    padding: EdgeInsets.zero,
                    activeColor: AppColors.white,
                    activeTrackColor: AppColors.orange,
                    inactiveThumbColor: AppColors.white,
                    inactiveTrackColor: AppColors.darkgrey,
                    value: context.locale.languageCode == Constants.en,
                    onChanged: (value) {
                      viewModel.doIntent(
                        SelectLanguageAction(
                          value ? Constants.en : Constants.ar,
                        ),
                      );
                      context.setLocale(
                        Locale(value ? Constants.en : Constants.ar),
                      );
                    },
                  ),
                ),
              ),
              ProfileMenuItemWidget(
                icon: AppIcons.lockSettingsIcon,
                label: LocaleKeys.Security.tr(),
                onTap: () {},
              ),
              ProfileMenuItemWidget(
                icon: AppIcons.securityWarningIcon,
                label: LocaleKeys.PrivacyPolicy.tr(),
                onTap: () {},
              ),
              ProfileMenuItemWidget(
                icon: AppIcons.helpIcon,
                label: LocaleKeys.Help.tr(),
                onTap: () {},
              ),
              ProfileMenuItemWidget(
                icon: AppIcons.logoutIcon,
                label: LocaleKeys.Logout.tr(),
                labelColor: AppColors.orange,
                onTap: () {
                  AppDialogs.showConfirmationDialog(
                    context,
                    message: LocaleKeys.AreYouSureToCloseTheApplication.tr(),
                    firstButtonText: LocaleKeys.No.tr(),
                    secondButtonText: LocaleKeys.Yes.tr(),
                    secondButtonAction: () {
                      viewModel.doIntent(LogoutAction());
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
