import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/features/change_password/presentation/view_model/change_password_cubit.dart';
import 'package:fitness_app/features/change_password/presentation/view_model/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/di/di.dart';
import '../../../../../core/utils/dialogs/app_dialogs.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/routes/app_routes.dart';
import '../widgets/change_password_form.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordCubit viewModel = getIt<ChangePasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state.changePasswordState is BaseLoadingState) {
            AppDialogs.showLoadingDialog(context);
          }
          if (state.changePasswordState is BaseSuccessState) {
            AppDialogs.hideLoading(context);
            Navigator.pushReplacementNamed(context, AppRoutes.mainLayoutRoute);
          }
          if (state.changePasswordState is BaseErrorState) {
            AppDialogs.hideLoading(context);
            AppDialogs.showFailureDialog(
              context,
              message:
                  (state.changePasswordState as BaseErrorState).errorMessage,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              LocaleKeys.ChangePassword.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.backgroundThree),
                fit: BoxFit.cover,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 140, left: 16, right: 16),
              child: Column(children: [ChangePasswordForm()]),
            ),
          ),
        ),
      ),
    );
  }
}
