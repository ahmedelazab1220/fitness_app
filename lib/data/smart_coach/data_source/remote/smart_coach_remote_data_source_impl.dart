import 'package:injectable/injectable.dart';

import '../../api/smart_coach_ai_service.dart';
import '../../models/message_dto.dart';
import '../../models/smart_coach_message_dto.dart';
import '../../models/user_message_dto.dart';
import '../contract/smart_coach_remote_data_source.dart';

@Injectable(as: SmartCoachRemoteDataSource)
class SmartCoachRemoteDataSourceImpl implements SmartCoachRemoteDataSource {
  final SmartCoachAiService _smartCoachAiService;

  SmartCoachRemoteDataSourceImpl(this._smartCoachAiService);

  @override
  Future<SmartCoachMessageDto> askSmartCoach(
    UserMessageDto userMessageDto,
    List<MessageDto> history,
  ) async {
    var smartCoachMessageDto = await _smartCoachAiService.askSmartCoach(
      userMessageDto,
      history,
    );
    return smartCoachMessageDto;
  }
}
