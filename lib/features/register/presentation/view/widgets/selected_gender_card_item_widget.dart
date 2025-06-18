import 'package:flutter/material.dart';

class SelectedGenderCardItemWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData iconData;

  const SelectedGenderCardItemWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xFFFF4100) : Colors.transparent,
          border: Border.all(color: const Color(0xFFD9D9D9), width: 1.5),
        ),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 50,
              color: isSelected ? Colors.white : const Color(0xFFD9D9D9),
            ),
            const SizedBox(height: 8.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}
