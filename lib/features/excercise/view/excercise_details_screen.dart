import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/utils/di/di.dart';
import 'package:fitness_app/data/excercise/model/response/difficulty_level_dto.dart';
import 'package:fitness_app/features/excercise/view_model/cubit/excercise_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/assets/app_colors.dart';
import '../../../core/assets/app_images.dart';
import '../../../core/base/base_state.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/l10n/locale_keys.g.dart';
import '../../../core/utils/shared_widgets/blured_container.dart';
import '../../../core/utils/shared_widgets/custom_tab_bar.dart';
import '../../../data/excercise/model/response/difficulty_levels_response_dto.dart';
import '../../../data/excercise/model/response/exercises_dto.dart';
import '../../../data/excercise/model/response/muscles_dto.dart';
import '../view_model/cubit/excercise_state.dart';

class ExcerciseDetailsScreen extends StatelessWidget {
  final MusclesDto muscleData;

  ExcerciseDetailsScreen({super.key, required this.muscleData});

  final viewModel = getIt<ExcerciseCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => viewModel
          ..doIntent(GetDifficultyLevelsAction(muscleId: muscleData.id ?? "")),
        child: Stack(
          children: [
            // Full-screen background
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.backgroundThree),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Scrollable content
            SingleChildScrollView(
              child: Column(
                children: [
                  // Top image with gradient and title
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: muscleData.image ?? "",
                        width: double.infinity,
                        height: 350,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Container(
                        height: 350,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.darkgrey,
                              AppColors.darkBlack.withOpacity(0.0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Text(
                          muscleData.name ?? "",
                          textAlign: TextAlign.center,
                          style: AppTheme.appTheme.textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                        ),
                      ),
                    ],
                  ),

                  // Blurred Container overlaps the image
                  Transform.translate(
                    offset: const Offset(0, -40),
                    // pull upward to overlap image
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BluredContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                textAlign: TextAlign.center,
                                style: AppTheme.appTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: 16,
                                      color: AppColors.white,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              BlocBuilder<ExcerciseCubit, ExcerciseState>(
                                builder: (context, state) {
                                  final difficultyState = state.difficultyState;
                                  final isError =
                                      difficultyState is BaseErrorState;
                                  if (isError) {
                                    return Center(
                                      child: Text(
                                        difficultyState.errorMessage,
                                        style: const TextStyle(
                                          color: AppColors.red,
                                        ),
                                      ),
                                    );
                                  }
                                  final isLoading =
                                      difficultyState is BaseLoadingState;
                                  final difficultyLevels =
                                      difficultyState
                                          is BaseSuccessState<
                                            DifficultyLevelsResponseDto
                                          >
                                      ? difficultyState.data?.difficultyLevels
                                      : List.generate(
                                          3,
                                          (index) => DifficultyLevelsDto(
                                            name: LocaleKeys.Loading.tr(),
                                          ),
                                        );
                                  final tabs = difficultyLevels
                                      ?.map((level) => level.name ?? '')
                                      .toList();
                                  return Column(
                                    children: [
                                      Skeletonizer(
                                        enabled: isLoading,
                                        child: CustomTabBar(
                                          tabs: tabs ?? [],
                                          selectedIndex:
                                              state.selectedLevelIndex,
                                          onTap: (index) => viewModel.doIntent(
                                            SelectLevelAction(
                                              index,
                                              muscleData.id ?? "",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<ExcerciseCubit, ExcerciseState>(
                    builder: (context, state) {
                      final excerciseState = state.excerciseState;
                      final isLoading = excerciseState is BaseLoadingState;
                      final isError = excerciseState is BaseErrorState;
                      final exercises = excerciseState is BaseSuccessState
                          ? viewModel.data
                          : [];

                      if (isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (isError) {
                        return Center(
                          child: Text(
                            excerciseState.errorMessage,
                            style: const TextStyle(color: AppColors.red),
                          ),
                        );
                      }

                      return SizedBox(
                        height: 500,
                        child: BluredContainer(
                          child: ListView.builder(
                            itemCount: exercises?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.zero,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageExerciseSelector(
                                      exercise: exercises![index],
                                    ),
                                    const SizedBox(width: 17),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            exercises[index].exercise
                                                .toString(),
                                            style: AppTheme
                                                .appTheme
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.white,
                                                ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            exercises[index].targetMuscleGroup
                                                .toString(),
                                            style: AppTheme
                                                .appTheme
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.white,
                                                ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            exercises[index].primaryEquipment
                                                .toString(),
                                            style: AppTheme
                                                .appTheme
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.white,
                                                ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    VideoSelectorWidget(
                                      exercise: exercises[index],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class VideoSelectorWidget extends StatelessWidget {
  const VideoSelectorWidget({super.key, required this.exercise});

  final ExercisesDto exercise;

  @override
  Widget build(BuildContext context) {
    return IconVideoWidget(
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

class IconVideoWidget extends StatelessWidget {
  const IconVideoWidget({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.orange[AppColors.baseColor],
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: const Icon(
          Icons.play_arrow,
          color: AppColors.darkBlack,
          size: 40,
        ),
      ),
    );
  }
}
