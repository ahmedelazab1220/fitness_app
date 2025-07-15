import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../entity/session_entity.dart';
import '../repo/smart_coach_repo.dart';

@injectable
class GetAllConversationUseCase {
  final SmartCoachRepo _smartCoachRepo;

  GetAllConversationUseCase(this._smartCoachRepo);

  Future<Result<Map<String, SessionEntity>>> call() async =>
      await _smartCoachRepo.getAllConversations();
}
