import 'package:json_annotation/json_annotation.dart';

part 'exercises_dto.g.dart';

@JsonSerializable()
class ExercisesDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "exercise")
  final String? exercise;
  @JsonKey(name: "short_youtube_demonstration")
  final String? shortYoutubeDemonstration;
  @JsonKey(name: "in_depth_youtube_explanation")
  final String? inDepthYoutubeExplanation;
  @JsonKey(name: "difficulty_level")
  final String? difficultyLevel;
  @JsonKey(name: "target_muscle_group")
  final String? targetMuscleGroup;
  @JsonKey(name: "prime_mover_muscle")
  final String? primeMoverMuscle;
  @JsonKey(name: "secondary_muscle")
  final String? secondaryMuscle;
  @JsonKey(name: "tertiary_muscle")
  final String? tertiaryMuscle;
  @JsonKey(name: "primary_equipment")
  final String? primaryEquipment;
  @JsonKey(name: "_primary_items")
  final int? primaryItems;
  @JsonKey(name: "secondary_equipment")
  final String? secondaryEquipment;
  @JsonKey(name: "_secondary_items")
  final int? secondaryItems;
  @JsonKey(name: "posture")
  final String? posture;
  @JsonKey(name: "single_or_double_arm")
  final String? singleOrDoubleArm;
  @JsonKey(name: "continuous_or_alternating_arms")
  final String? continuousOrAlternatingArms;
  @JsonKey(name: "grip")
  final String? grip;
  @JsonKey(name: "load_position_ending")
  final String? loadPositionEnding;
  @JsonKey(name: "continuous_or_alternating_legs")
  final String? continuousOrAlternatingLegs;
  @JsonKey(name: "foot_elevation")
  final String? footElevation;
  @JsonKey(name: "combination_exercises")
  final String? combinationExercises;
  @JsonKey(name: "movement_pattern_1")
  final String? movementPattern1;
  @JsonKey(name: "movement_pattern_2")
  final String? movementPattern2;
  @JsonKey(name: "movement_pattern_3")
  final String? movementPattern3;
  @JsonKey(name: "plane_of_motion_1")
  final String? planeOfMotion1;
  @JsonKey(name: "plane_of_motion_2")
  final String? planeOfMotion2;
  @JsonKey(name: "plane_of_motion_3")
  final String? planeOfMotion3;
  @JsonKey(name: "body_region")
  final String? bodyRegion;
  @JsonKey(name: "force_type")
  final String? forceType;
  @JsonKey(name: "mechanics")
  final String? mechanics;
  @JsonKey(name: "laterality")
  final String? laterality;
  @JsonKey(name: "primary_exercise_classification")
  final String? primaryExerciseClassification;
  @JsonKey(name: "short_youtube_demonstration_link")
  final String? shortYoutubeDemonstrationLink;
  @JsonKey(name: "in_depth_youtube_explanation_link")
  final String? inDepthYoutubeExplanationLink;

  ExercisesDto({
    this.id,
    this.exercise,
    this.shortYoutubeDemonstration,
    this.inDepthYoutubeExplanation,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.secondaryMuscle,
    this.tertiaryMuscle,
    this.primaryEquipment,
    this.primaryItems,
    this.secondaryEquipment,
    this.secondaryItems,
    this.posture,
    this.singleOrDoubleArm,
    this.continuousOrAlternatingArms,
    this.grip,
    this.loadPositionEnding,
    this.continuousOrAlternatingLegs,
    this.footElevation,
    this.combinationExercises,
    this.movementPattern1,
    this.movementPattern2,
    this.movementPattern3,
    this.planeOfMotion1,
    this.planeOfMotion2,
    this.planeOfMotion3,
    this.bodyRegion,
    this.forceType,
    this.mechanics,
    this.laterality,
    this.primaryExerciseClassification,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  factory ExercisesDto.fromJson(Map<String, dynamic> json) {
    return _$ExercisesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExercisesDtoToJson(this);
  }

  // ExerciseEntity toEntity() {
  //   return ExerciseEntity(
  //     id: id,
  //     exercise: exercise,
  //     shortYoutubeDemonstration: shortYoutubeDemonstration,
  //     inDepthYoutubeExplanation: inDepthYoutubeExplanation,
  //     difficultyLevel: difficultyLevel,
  //     targetMuscleGroup: targetMuscleGroup,
  //     primeMoverMuscle: primeMoverMuscle,
  //     secondaryMuscle: secondaryMuscle,
  //     tertiaryMuscle: tertiaryMuscle,
  //     primaryEquipment: primaryEquipment,
  //     primaryItems: primaryItems,
  //     secondaryEquipment: secondaryEquipment,
  //     secondaryItems: secondaryItems,
  //     posture: posture,
  //     singleOrDoubleArm: singleOrDoubleArm,
  //     continuousOrAlternatingArms: continuousOrAlternatingArms,
  //     grip: grip,
  //     loadPositionEnding: loadPositionEnding,
  //     continuousOrAlternatingLegs: continuousOrAlternatingLegs,
  //     footElevation: footElevation,
  //     combinationExercises: combinationExercises,
  //     movementPattern1: movementPattern1,
  //     movementPattern2: movementPattern2,
  //     movementPattern3: movementPattern3,
  //     planeOfMotion1: planeOfMotion1,
  //     planeOfMotion2: planeOfMotion2,
  //     planeOfMotion3: planeOfMotion3,
  //     bodyRegion: bodyRegion,
  //     forceType: forceType,
  //     mechanics: mechanics,
  //     laterality: laterality,
  //     primaryExerciseClassification: primaryExerciseClassification,
  //     shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLink,
  //     inDepthYoutubeExplanationLink: inDepthYoutubeExplanationLink,
  //   );
  // }
}
