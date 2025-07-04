import 'package:json_annotation/json_annotation.dart';

import 'muscles_group_dto.dart';

part 'workouts_response_dto.g.dart';

@JsonSerializable()
class WorkoutsResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "musclesGroup")
  final List<MusclesGroupDto>? musclesGroup;

  WorkoutsResponseDto({this.message, this.musclesGroup});

  factory WorkoutsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$WorkoutsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WorkoutsResponseDtoToJson(this);
  }
}
