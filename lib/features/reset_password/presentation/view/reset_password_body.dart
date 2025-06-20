import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../core/utils/shared_widgets/shared_auth_layout.dart';
import 'reset_password_form.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedAuthLayout(
      title: LocaleKeys.MakeSureIts8CharacterOrMore.tr(),
      subtitle: LocaleKeys.CreateNewPassword.tr(),
      reverseOrder: true,
      child: const ResetPasswordForm(),
    );
  }
}
