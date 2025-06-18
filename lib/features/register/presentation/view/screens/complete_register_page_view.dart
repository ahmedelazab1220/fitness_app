import 'package:fitness_app/features/register/presentation/view/widgets/circular_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/assets/app_images.dart';
import '../../view_model/cubit/register_cubit.dart';

class CompleteRegisterPageView extends StatelessWidget {
  const CompleteRegisterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ModalRoute.of(context)?.settings.arguments as RegisterCubit;
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
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
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    final cubit = context.read<RegisterCubit>();
                    return CircularIndicatorWidget(
                      current: state.stepIndex + 1,
                      total: cubit.pages.length,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PageView.builder(
                    controller: cubit.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.pages.length,
                    itemBuilder: (_, i) => cubit.pages[i],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
