import 'package:fitness_app/features/register/presentation/view/widgets/already_have_account_text.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/register_form.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/register_header.dart';
import 'package:flutter/material.dart';

import '../../../../core/assets/app_images.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundTwo),
            fit: BoxFit.fill,
          ),
        ),
        child: const Form(
          child: Column(
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
    );
  }
}
