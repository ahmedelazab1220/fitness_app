import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../data/excercise/model/response/exercises_dto.dart';

class ImageExerciseSelector extends StatelessWidget {
  const ImageExerciseSelector({super.key, required this.exercise});

  final ExercisesDto exercise;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 88,
        width: 81,
        child: CachedNetworkImage(
          imageUrl: _getThumbnailUrl(
            exercise.shortYoutubeDemonstrationLink.toString(),
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  String _getThumbnailUrl(String videoUrl) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }
}
