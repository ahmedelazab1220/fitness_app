import 'package:flutter/material.dart';
import '../../../../../core/utils/shared_widgets/blured_container.dart';
import 'profile_menu_list_widget.dart';
import 'profile_header_widget.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileHeaderWidget(),
        SizedBox(height: 40),
        BluredContainer(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: ProfileMenuList(),
        ),
      ],
    );
  }
}
