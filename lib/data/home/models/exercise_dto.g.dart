// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseDto _$ExerciseDtoFromJson(Map<String, dynamic> json) => ExerciseDto(
  id: json['_id'] as String?,
  exercise: json['exercise'] as String?,
  shortYoutubeDemonstration: json['short_youtube_demonstration'] as String?,
  inDepthYoutubeExplanation: json['in_depth_youtube_explanation'] as String?,
  difficultyLevel: json['difficulty_level'] as String?,
  targetMuscleGroup: json['target_muscle_group'] as String?,
  primeMoverMuscle: json['prime_mover_muscle'] as String?,
  secondaryMuscle: json['secondary_muscle'],
  tertiaryMuscle: json['tertiary_muscle'],
  primaryEquipment: json['primary_equipment'] as String?,
  primaryItems: (json['primary_items'] as num?)?.toInt(),
  secondaryEquipment: json['secondary_equipment'],
  secondaryItems: (json['secondary_items'] as num?)?.toInt(),
  posture: json['posture'] as String?,
  singleOrDoubleArm: json['single_or_double_arm'] as String?,
  continuousOrAlternatingArms:
      json['continuous_or_alternating_arms'] as String?,
  grip: json['grip'] as String?,
  loadPositionEnding: json['load_position_ending'] as String?,
  continuousOrAlternatingLegs:
      json['continuous_or_alternating_legs'] as String?,
  footElevation: json['foot_elevation'] as String?,
  combinationExercises: json['combination_exercises'] as String?,
  movementPattern1: json['movement_pattern_1'] as String?,
  movementPattern2: json['movement_pattern_2'],
  movementPattern3: json['movement_pattern_3'],
  planeOfMotion1: json['plane_of_motion_1'] as String?,
  planeOfMotion2: json['plane_of_motion_2'],
  planeOfMotion3: json['plane_of_motion_3'],
  bodyRegion: json['body_region'] as String?,
  forceType: json['force_type'] as String?,
  mechanics: json['mechanics'] as String?,
  laterality: json['laterality'] as String?,
  primaryExerciseClassification:
      json['primary_exercise_classification'] as String?,
  shortYoutubeDemonstrationLink:
      json['short_youtube_demonstration_link'] as String?,
  inDepthYoutubeExplanationLink:
      json['in_depth_youtube_explanation_link'] as String?,
);

Map<String, dynamic> _$ExerciseDtoToJson(
  ExerciseDto instance,
) => <String, dynamic>{
  '_id': instance.id,
  'exercise': instance.exercise,
  'short_youtube_demonstration': instance.shortYoutubeDemonstration,
  'in_depth_youtube_explanation': instance.inDepthYoutubeExplanation,
  'difficulty_level': instance.difficultyLevel,
  'target_muscle_group': instance.targetMuscleGroup,
  'prime_mover_muscle': instance.primeMoverMuscle,
  'secondary_muscle': instance.secondaryMuscle,
  'tertiary_muscle': instance.tertiaryMuscle,
  'primary_equipment': instance.primaryEquipment,
  'primary_items': instance.primaryItems,
  'secondary_equipment': instance.secondaryEquipment,
  'secondary_items': instance.secondaryItems,
  'posture': instance.posture,
  'single_or_double_arm': instance.singleOrDoubleArm,
  'continuous_or_alternating_arms': instance.continuousOrAlternatingArms,
  'grip': instance.grip,
  'load_position_ending': instance.loadPositionEnding,
  'continuous_or_alternating_legs': instance.continuousOrAlternatingLegs,
  'foot_elevation': instance.footElevation,
  'combination_exercises': instance.combinationExercises,
  'movement_pattern_1': instance.movementPattern1,
  'movement_pattern_2': instance.movementPattern2,
  'movement_pattern_3': instance.movementPattern3,
  'plane_of_motion_1': instance.planeOfMotion1,
  'plane_of_motion_2': instance.planeOfMotion2,
  'plane_of_motion_3': instance.planeOfMotion3,
  'body_region': instance.bodyRegion,
  'force_type': instance.forceType,
  'mechanics': instance.mechanics,
  'laterality': instance.laterality,
  'primary_exercise_classification': instance.primaryExerciseClassification,
  'short_youtube_demonstration_link': instance.shortYoutubeDemonstrationLink,
  'in_depth_youtube_explanation_link': instance.inDepthYoutubeExplanationLink,
};
