import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/login_cubit.dart';

class DoNotHaveAccount extends StatelessWidget {
  final LoginCubit viewModel;

  const DoNotHaveAccount(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        viewModel.doIntent(
          NavigationAction(
            routeName: '/register',
            type: NavigationType.pushReplacement,
          ),
        );
      },
      child: Text.rich(
        TextSpan(
          text: "${LocaleKeys.DonotHaveAnAccountYet.tr()} ",
          style: const TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: LocaleKeys.Register.tr(),
              style: const TextStyle(
                color: Colors.orange,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
