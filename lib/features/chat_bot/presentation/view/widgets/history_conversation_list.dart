import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/l10n/locale_keys.g.dart';
import '../../view_model/cubit/smart_coach_cubit.dart';

class HistoryConversationList extends StatelessWidget {
  const HistoryConversationList({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<SmartCoachCubit>();
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final session = viewModel.sessions.values.toList()[index];
        return FadeInRight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                title: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    color: AppColors.white.withAlpha(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          session.title,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_horiz,
                            color: AppColors.white,
                          ),
                          padding: EdgeInsets.zero,
                          color: AppColors.darkgrey,
                          offset: const Offset(0, 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          onSelected: (value) {
                            if (value == Constants.delete) {
                              viewModel.doIntent(
                                DeleteConversationAction(
                                  conversationId: session.sessionId,
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem<String>(
                              height: 24.0,
                              value: Constants.delete,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.delete,
                                    color: AppColors.red,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    LocaleKeys.Delete.tr(),
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onTap: () {
                  viewModel.doIntent(
                    GetOldConversation(conversationId: session.sessionId),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }, childCount: viewModel.sessions.length),
    );
  }
}
