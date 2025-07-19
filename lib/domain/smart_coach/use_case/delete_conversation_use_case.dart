import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_result.dart';
import '../repo/smart_coach_repo.dart';

@injectable
class DeleteConversationUseCase {
  final SmartCoachRepo _smartCoachRepo;

  DeleteConversationUseCase(this._smartCoachRepo);

  Future<Result<void>> call(String sessionId) async =>
      await _smartCoachRepo.deleteConversation(sessionId);
}
