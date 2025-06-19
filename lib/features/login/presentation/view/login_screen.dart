import 'package:fitness_app/core/base/base_state.dart';
import 'package:fitness_app/core/utils/dialogs/app_dialogs.dart';
import 'package:fitness_app/features/login/presentation/view/widgets/login_form.dart';
import 'package:fitness_app/features/login/presentation/view/widgets/login_header.dart';
import 'package:fitness_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_images.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final viewModel = getIt<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is BaseLoadingState) {
              AppDialogs.showLoadingDialog(context);
            } else if (state is BaseSuccessState) {
              AppDialogs.hideLoading(context);
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.mainLayoutRoute,
              );
            } else if (state is BaseErrorState) {
              AppDialogs.hideLoading(context);
              AppDialogs.showFailureDialog(
                context,
                message: (state.loginState as BaseErrorState).errorMessage,
              );
            }
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.backgroundTwo),
                fit: BoxFit.fill,
              ),
            ),
            child: Form(
              key: viewModel.formKey,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [LoginHeader(), LoginForm()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
