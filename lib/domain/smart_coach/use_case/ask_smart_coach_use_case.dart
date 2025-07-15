import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/smart_coach_message_entity.dart';
import '../entity/user_message_entity.dart';
import '../repo/smart_coach_repo.dart';

@injectable
class AskSmartCoachUseCase {
  final SmartCoachRepo _smartCoachRepo;

  AskSmartCoachUseCase(this._smartCoachRepo);

  Future<Result<SmartCoachMessageEntity>> call(
    UserMessageEntity userMessageEntity,
    String sessionId,
  ) async => await _smartCoachRepo.askSmartCoach(userMessageEntity, sessionId);
}
