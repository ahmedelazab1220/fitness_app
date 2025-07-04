import 'package:fitness_app/features/profile/presentation/view/widgets/profile_menu_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/shared_widgets/blured_container.dart';
import '../../../../../domain/auth/entity/user_entity.dart';
import '../../view_model/profile_cubit.dart';
import '../../view_model/profile_state.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profileState = state.profileState;
        if (profileState is BaseLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (profileState is BaseSuccessState<UserEntity>) {
          final user = profileState.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.photo!),
              ),
              const SizedBox(height: 8),
              Text(
                '${user.firstName!} ${user.lastName!}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 40),
              const BluredContainer(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ProfileMenuList(),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
