import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/l10n/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../domain/auth/entity/user_entity.dart';
import '../../view_model/profile_cubit.dart';
import '../../view_model/profile_state.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profileState = state.profileState;

        final isLoading = profileState is BaseLoadingState;
        final user = (profileState is BaseSuccessState<UserEntity>)
            ? profileState.data
            : null;

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: user?.photo != null
                    ? NetworkImage(user!.photo!)
                    : null,
                child: user?.photo == null
                    ? const Icon(Icons.person, size: 40)
                    : null,
              ),
              const SizedBox(height: 8),
              Text(
                user != null
                    ? '${user.firstName ?? ''} ${user.lastName ?? ''}'
                    : LocaleKeys.Loading.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
