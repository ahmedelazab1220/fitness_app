import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/assets/app_icons.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/smart_coach_cubit.dart';

class SmartCoachAppBar extends StatelessWidget {
  const SmartCoachAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<SmartCoachCubit>();
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.orange,
              radius: 14,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  size: 28,
                  Icons.arrow_left_rounded,
                  color: AppColors.white,
                ),
                onPressed: () {
                  viewModel.doIntent(
                    ChangePageAction(
                      index: viewModel.state.currentPageIndex! - 1,
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Text(
              LocaleKeys.SmartCoach.tr(),
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Builder(
              builder: (context) => InkWell(
                onTap: () {
                  viewModel.doIntent(GetAllConversationsAction());
                  Scaffold.of(context).openEndDrawer();
                },
                child: SvgPicture.asset(AppIcons.historyIcon),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
