import 'package:flutter/material.dart';

import '../../../../../core/assets/app_colors.dart';

class AnimatedIconLabel extends StatefulWidget {
  const AnimatedIconLabel({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final void Function()? onTap;

  @override
  State<AnimatedIconLabel> createState() => _AnimatedIconLabelState();
}

class _AnimatedIconLabelState extends State<AnimatedIconLabel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _bounceAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    _fadeAnimation = Tween<double>(begin: 0.5, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat(reverse: true, period: const Duration(seconds: 2));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      splashColor: AppColors.white[AppColors.colorCode100],
      onTap: widget.onTap,
      child: SizedBox(
        child: Row(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _bounceAnimation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Icon(
                      widget.icon,
                      color: AppColors.orange,
                      shadows: const [
                        Shadow(
                          color: AppColors.orange,
                          blurRadius: 6.0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12.0),
            Text(
              widget.label,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
