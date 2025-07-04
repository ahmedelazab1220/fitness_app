import 'package:fitness_app/core/utils/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/utils/dialogs/app_dialogs.dart';
import '../../../../core/utils/routes/app_routes.dart';
import '../view_model/cubit/login_cubit.dart';
import 'widget/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<LoginCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is BaseLoadingState) {
            AppDialogs.showLoadingDialog(context);
          } else if (state is BaseSuccessState) {
            AppDialogs.hideLoading(context);
            Navigator.pushReplacementNamed(context, AppRoutes.mainLayoutRoute);
          } else if (state is BaseErrorState) {
            AppDialogs.hideLoading(context);
            AppDialogs.showFailureDialog(
              context,
              message: (state.baseState as BaseErrorState).errorMessage,
            );
          }
        },
        child: const Scaffold(body: LoginForm()),
      ),
    );
  }
}
