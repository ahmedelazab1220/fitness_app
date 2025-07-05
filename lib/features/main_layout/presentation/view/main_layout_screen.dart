import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/assets/app_colors.dart';
import '../../../../core/assets/app_icons.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/l10n/locale_keys.g.dart';
import '../view_model/cubit/main_layout_cubit.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  late final MainLayoutCubit viewModel;

  final List<String> _icons = [
    AppIcons.homeIcon,
    AppIcons.chatIcon,
    AppIcons.workoutIcon,
    AppIcons.profileIcon,
  ];

  final List<String> _labels = [
    LocaleKeys.Home.tr(),
    LocaleKeys.FitnessAI.tr(),
    LocaleKeys.Workouts.tr(),
    LocaleKeys.Profile.tr(),
  ];

  @override
  void initState() {
    viewModel = getIt<MainLayoutCubit>();
    super.initState();
  }

  void _onItemTapped(int index) {
    viewModel.doIntent(ChangeSelectedTab(MainLayoutTabs.values[index]));
  }

  Widget _buildNavItem(String asset, String label, int index) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        final isSelected = viewModel.currentTab.index == index;

        return Expanded(
          child:
              InkWell(
                onTap: () => _onItemTapped(index),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                          asset,
                          colorFilter: isSelected
                              ? const ColorFilter.mode(
                                  AppColors.orange,
                                  BlendMode.srcIn,
                                )
                              : null,
                        )
                        .animate(target: isSelected ? 1 : 0)
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.2, 1.2),
                          duration: 300.ms,
                          curve: Curves.easeOutBack,
                        ),
                    const SizedBox(height: 4),
                    if (isSelected)
                      Text(
                            label,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.orange),
                          )
                          .animate()
                          .fadeIn(duration: 200.ms, curve: Curves.easeIn)
                          .slideY(
                            begin: 0.5,
                            end: 0,
                            duration: 200.ms,
                            curve: Curves.easeOut,
                          ),
                  ],
                ),
              ).animate().fadeIn(
                delay: (100 * index).ms,
                duration: 300.ms,
                curve: Curves.easeOut,
              ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocBuilder<MainLayoutCubit, MainLayoutState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                // Main content of the current tab
                AnimatedSwitcher(
                  duration: 400.ms,
                  transitionBuilder: (child, animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: viewModel.tabs[viewModel.currentTab]?.call(),
                ),
                // Bottom navigation bar overlay
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child:
                      AnimatedContainer(
                            margin: const EdgeInsets.all(32.0),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 24.0,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.darkgrey.withAlpha(225),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            duration: 300.ms,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                _icons.length,
                                (index) => _buildNavItem(
                                  _icons[index],
                                  _labels[index],
                                  index,
                                ),
                              ),
                            ),
                          )
                          .animate()
                          .slideY(
                            begin: 1,
                            end: 0,
                            duration: 500.ms,
                            curve: Curves.easeOutCubic,
                            delay: 200.ms,
                          )
                          .fadeIn(duration: 500.ms, delay: 200.ms),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
