import 'package:fitness_app/core/utils/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/utils/dialogs/app_dialogs.dart';
import '../../../../core/utils/routes/app_routes.dart';
import '../view_model/cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final viewModel = getIt<RegisterCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.registerState is BaseLoadingState) {
            AppDialogs.showLoadingDialog(context);
          }
          if (state.registerState is BaseSuccessState) {
            AppDialogs.hideLoading(context);
            Navigator.pushReplacementNamed(context, AppRoutes.mainLayoutRoute);
          }
          if (state.registerState is BaseErrorState) {
            AppDialogs.hideLoading(context);
            AppDialogs.showFailureDialog(
              context,
              message: (state.registerState as BaseErrorState).errorMessage,
            );
          }
        },
        child: Scaffold(
          body: PageView.builder(
            controller: viewModel.pageController,
            onPageChanged: (index) =>
                viewModel.doIntent(ChangeStepAction(index)),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.pages.length,
            itemBuilder: (_, i) => viewModel.pages[i],
          ),
        ),
      ),
    );
  }
}
