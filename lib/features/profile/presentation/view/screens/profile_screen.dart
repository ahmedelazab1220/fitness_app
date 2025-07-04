import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/assets/app_images.dart';
import 'package:fitness_app/core/utils/di/di.dart';
import 'package:fitness_app/core/utils/dialogs/app_dialogs.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:fitness_app/features/profile/presentation/view/widgets/profile_body.dart';
import 'package:fitness_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/routes/app_routes.dart';
import '../../view_model/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileCubit viewModel = getIt<ProfileCubit>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => viewModel..doIntent(GetProfileAction()),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          final logoutState = state.logoutState;
          if (state.profileState is BaseErrorState) {
            AppDialogs.showFailureDialog(
              context,
              message: (state.profileState as BaseErrorState).errorMessage,
            );
          }
          if (logoutState is BaseSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginRoute,
              (route) => false,
            );
          } else if (logoutState is BaseErrorState) {
            AppDialogs.showFailureDialog(
              context,
              message: logoutState.errorMessage,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              LocaleKeys.Profile.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            leading: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(const Size(24, 24)),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.orange,
                shape: const CircleBorder(),
              ),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: 10,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.backgroundThree),
                fit: BoxFit.fill,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ProfileBody(),
            ),
          ),
        ),
      ),
    );
  }
}
