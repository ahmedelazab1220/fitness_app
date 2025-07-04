import 'package:fitness_app/features/excercise/view/widgets/youtube_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../data/excercise/model/response/exercises_dto.dart';
import 'icon_video.dart';

class VideoSelectorWidget extends StatelessWidget {
  const VideoSelectorWidget({super.key, required this.exercise});

  final ExercisesDto exercise;

  @override
  Widget build(BuildContext context) {
    return IconVideo(
      onPressed: () {
        _playVideo(context, exercise.shortYoutubeDemonstrationLink.toString());
      },
    );
  }

  void _playVideo(BuildContext context, String videoUrl) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: YoutubePlayerWidget(
                controller: YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
