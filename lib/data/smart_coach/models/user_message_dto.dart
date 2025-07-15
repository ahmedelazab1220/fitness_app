import 'package:json_annotation/json_annotation.dart';

import '../../../domain/smart_coach/entity/user_message_entity.dart';

part 'user_message_dto.g.dart';

@JsonSerializable()
class UserMessageDto {
  final String message;

  UserMessageDto(this.message);

  factory UserMessageDto.fromJson(Map<String, dynamic> json) =>
      _$UserMessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserMessageDtoToJson(this);

  factory UserMessageDto.fromDomain(UserMessageEntity entity) =>
      UserMessageDto(entity.message);
}
