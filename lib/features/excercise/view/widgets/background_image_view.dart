import 'package:flutter/material.dart';

import '../../../../core/assets/app_images.dart';

class BackgroundImageView extends StatelessWidget {
  const BackgroundImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundThree),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
