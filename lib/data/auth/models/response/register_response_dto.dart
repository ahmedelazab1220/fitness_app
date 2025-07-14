import 'package:fitness_app/data/auth/models/response/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_response_dto.g.dart';

@JsonSerializable()
class RegisterResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final User? user;
  @JsonKey(name: "token")
  final String? token;

  RegisterResponseDto({this.message, this.user, this.token});

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) {
    return _$RegisterResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterResponseDtoToJson(this);
  }
}
