import 'package:fitness_app/features/register/presentation/view/screens/gender_selection_screen.dart';
import 'package:fitness_app/features/register/presentation/view/widgets/circular_indicator_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/assets/app_images.dart';

class CompleteRegisterPageView extends StatelessWidget {
  CompleteRegisterPageView({super.key});

  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const GenderSelectionScreen(),
    Container(color: Colors.green),
    Container(color: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundTwo),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            children: [
              CircularIndicatorWidget(progress: 2, current: 2, total: 5),
              const SizedBox(height: 16),
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) => _pages[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
