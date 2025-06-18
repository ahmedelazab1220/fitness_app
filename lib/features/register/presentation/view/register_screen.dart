import 'package:fitness_app/core/utils/di/di.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/already_have_account_text.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/register_form.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/register_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/assets/app_images.dart';
import '../view_model/cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final viewModel = getIt<RegisterCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Container(
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
              children: [
                RegisterHeader(),
                RegisterForm(),
                AlreadyHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
