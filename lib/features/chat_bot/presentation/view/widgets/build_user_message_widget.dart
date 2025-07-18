import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/assets/app_colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/auth/models/user_dto.dart';

class BuildUserMessageWidget extends StatelessWidget {
  final String message;
  const BuildUserMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 32.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.red[AppColors.colorCode20],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ValueListenableBuilder(
            valueListenable: Hive.box<UserDto>(Constants.userBox).listenable(),
            builder: (context, box, _) {
              final user = box.get(Constants.userBox)!.toEntity();
              return CircleAvatar(
                radius: 25.0,
                backgroundImage: CachedNetworkImageProvider(user.photo!),
              );
            },
          ),
        ],
      ),
    );
  }
}
