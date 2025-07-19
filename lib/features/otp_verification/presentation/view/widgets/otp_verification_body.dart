import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../../../../core/utils/shared_widgets/shared_auth_layout.dart';
import 'otp_verification_form.dart';

class OtpVerificationBody extends StatelessWidget {
  const OtpVerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedAuthLayout(
      title: LocaleKeys.OtpCode.tr(),
      subtitle: LocaleKeys.EnterYourOTPCheckYourEmail.tr(),
      child: const OtpVerificationForm(),
    );
  }
}
