import 'package:fitness_app/features/register/presentation/view/widgets/circular_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../view_model/cubit/register_cubit.dart';

class CompleteRegisterPageView extends StatelessWidget {
  const CompleteRegisterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (ctx, state) {
        final cubit = ctx.read<RegisterCubit>();

        final idx = state.stepIndex;
        final pages = cubit.pages;

        Widget indicator = const SizedBox.shrink();
        if (idx >= 0 && idx < pages.length) {
          const total = 6;
          final current = idx + 1;
          final prog = current / total;
          indicator = CircularIndicatorWidget(
            progress: prog,
            current: current,
            total: total,
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 100,
            title: Image.asset(AppImages.appLogo, width: 140, height: 100),
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.backgroundTwo),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                children: [
                  indicator,
                  const SizedBox(height: 16),
                  Expanded(
                    child: PageView.builder(
                      controller: cubit.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pages.length,
                      itemBuilder: (_, i) => pages[i],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
