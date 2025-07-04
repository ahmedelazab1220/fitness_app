import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/assets/app_colors.dart';

class YoutubePlayerWidget extends StatelessWidget {
  const YoutubePlayerWidget({
    super.key,
    required this.controller,
    this.thumbnail,
  });

  final Widget? thumbnail;
  final YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: AppColors.orange[AppColors.baseColor],
      progressColors: ProgressBarColors(
        bufferedColor: AppColors.orange[AppColors.baseColor]?.withValues(
          alpha: .5,
        ),
        playedColor: AppColors.orange[AppColors.baseColor],
        backgroundColor: AppColors.darkgrey.withValues(alpha: .2),
        handleColor: AppColors.orange[AppColors.baseColor],
      ),
      thumbnail: thumbnail,
      aspectRatio: 16 / 9,
    );
  }
}
