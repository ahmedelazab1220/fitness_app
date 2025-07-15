import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/smart_coach_cubit.dart';
import 'animated_icon_label.dart';
import 'history_conversation_list.dart';

class BuildHistoryConversationWidget extends StatelessWidget {
  const BuildHistoryConversationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<SmartCoachCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AnimatedIconLabel(
                    label: LocaleKeys.NewChat.tr(),
                    icon: Icons.open_in_new_rounded,
                    onTap: () {
                      viewModel.doIntent(StartNewChatAction());
                      Navigator.pop(context);
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(color: AppColors.white.withAlpha(50)),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: AnimatedIconLabel(
                      label: LocaleKeys.History.tr(),
                      icon: Icons.history_rounded,
                    ),
                  ),
                ),
                const HistoryConversationList(),
              ],
            ),
          ),
          Divider(color: AppColors.white.withAlpha(50)),
          const SizedBox(height: 8.0),
          FadeInLeft(
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: CachedNetworkImageProvider(
                    Constants.fakeImage,
                  ),
                ),
                SizedBox(width: 12.0),
                Text(
                  'Ahmed Elazab',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
