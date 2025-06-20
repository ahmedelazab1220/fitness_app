import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/dialogs/app_toast.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../core/utils/routes/app_routes.dart';
import '../view_model/cubit/otp_verification_cubit.dart';
import 'widgets/otp_verification_body.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final OtpVerificationCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<OtpVerificationCubit>();
    viewModel.email.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<OtpVerificationCubit, OtpVerificationState>(
        listener: (context, state) {
          if (state.baseState is BaseSuccessState) {
            showToast(
              title: LocaleKeys.OtpVerificationSuccessfully.tr(),
              color: AppColors.orange,
            );
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.resetPasswordRoute,
              arguments: {Constants.email: widget.email},
            );
          }
          if (state.baseState is BaseErrorState) {
            showToast(
              title: (state.baseState as BaseErrorState).errorMessage,
              color: AppColors.red,
            );
          }
        },
        child: const Scaffold(body: OtpVerificationBody()),
      ),
    );
  }
}
