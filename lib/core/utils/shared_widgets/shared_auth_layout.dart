import 'package:flutter/material.dart';

import '../../assets/app_colors.dart';
import '../../assets/app_images.dart';

class SharedAuthLayout extends StatelessWidget {
  const SharedAuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.reverseOrder = false,
    this.setBackButton = true,
  });

  final String title;
  final String subtitle;
  final Widget? child;
  final bool? reverseOrder;
  final bool? setBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.backgroundTwo),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50.0),
                  Row(
                    children: [
                      setBackButton == true
                          ? CircleAvatar(
                              backgroundColor: AppColors.orange,
                              radius: 14,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  size: 28,
                                  Icons.arrow_left_rounded,
                                  color: AppColors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            )
                          : const SizedBox.shrink(),
                      const Spacer(),
                      Image.asset(AppImages.appLogoImage),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 60.0),
                  if (reverseOrder!)
                    _buildSubtitle(context)
                  else
                    _buildTitle(context),
                  if (reverseOrder!)
                    _buildTitle(context)
                  else
                    _buildSubtitle(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          if (child != null) SliverToBoxAdapter(child: child!),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
      ),
    );
  }
}
