import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/login_cubit.dart';

class ForgotPasswordButton extends StatelessWidget {
  final LoginCubit viewModel;

  const ForgotPasswordButton(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => viewModel.doIntent(
          NavigationAction(routeName: '/forgot', type: NavigationType.push),
        ),
        child: Text(
          LocaleKeys.ForgotPassword.tr(),
          style: const TextStyle(color: Colors.orange),
        ),
      ),
    );
  }
}
