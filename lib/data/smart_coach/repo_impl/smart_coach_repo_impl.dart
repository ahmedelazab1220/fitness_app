import 'package:injectable/injectable.dart';

import '../../../core/utils/datasource_excution/api_manager.dart';
import '../../../core/utils/datasource_excution/api_result.dart';
import '../../../domain/smart_coach/entity/session_entity.dart';
import '../../../domain/smart_coach/entity/smart_coach_message_entity.dart';
import '../../../domain/smart_coach/entity/user_message_entity.dart';
import '../../../domain/smart_coach/repo/smart_coach_repo.dart';
import '../data_source/contract/smart_coach_local_data_source.dart';
import '../data_source/contract/smart_coach_remote_data_source.dart';
import '../models/message_dto.dart';
import '../models/user_message_dto.dart';

@Injectable(as: SmartCoachRepo)
class SmartCoachRepoImpl implements SmartCoachRepo {
  final SmartCoachRemoteDataSource _smartCoachRemoteDataSource;
  final SmartCoachLocalDataSource _smartCoachLocalDataSource;
  final ApiManager _apiManager;

  SmartCoachRepoImpl(
    this._smartCoachRemoteDataSource,
    this._smartCoachLocalDataSource,
    this._apiManager,
  );

  @override
  Future<Result<SmartCoachMessageEntity>> askSmartCoach(
    UserMessageEntity userMessageEntity,
    String sessionId,
  ) async {
    List<MessageDto> history = await _smartCoachLocalDataSource
        .getLastTenMessagesInConversationBySessionId(sessionId);

    var response = await _apiManager.execute<SmartCoachMessageEntity>(() async {
      var remoteResponse = await _smartCoachRemoteDataSource.askSmartCoach(
        UserMessageDto.fromDomain(userMessageEntity),
        history,
      );

      await _apiManager.execute(() async {
        var response = await _smartCoachLocalDataSource.saveSmartCoachMessage(
          userMessageEntity.message,
          remoteResponse.content,
          remoteResponse.content,
          sessionId,
        );
        return response;
      });

      return remoteResponse.toEntity();
    });
    return response;
  }

  @override
  Future<Result<Map<String, SessionEntity>>> getAllConversations() async {
    var response = await _apiManager.execute<Map<String, SessionEntity>>(
      () async {
        var response = await _smartCoachLocalDataSource.getAllConversations();
        return response.map((key, value) => MapEntry(key, value.toEntity()));
      },
    );
    return response;
  }

  @override
  Future<Result<void>> deleteConversation(String sessionId) async {
    return await _apiManager.execute(() async {
      await _smartCoachLocalDataSource.deleteConversation(sessionId);
    });
  }
}
