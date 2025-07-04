import 'package:fitness_app/core/assets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final String icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? labelColor;

  const ProfileMenuItemWidget({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(AppColors.orange, BlendMode.srcIn),
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: labelColor ?? AppColors.white,
        ),
      ),
      trailing:
          trailing ??
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.orange,
            size: 16,
          ),
      onTap: onTap,
    );
  }
}
