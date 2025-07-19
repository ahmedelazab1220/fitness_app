import '../../models/message_dto.dart';
import '../../models/smart_coach_message_dto.dart';
import '../../models/user_message_dto.dart';

abstract class SmartCoachRemoteDataSource {
  Future<SmartCoachMessageDto> askSmartCoach(
    UserMessageDto userMessageDto,
    List<MessageDto> history,
  );
}
