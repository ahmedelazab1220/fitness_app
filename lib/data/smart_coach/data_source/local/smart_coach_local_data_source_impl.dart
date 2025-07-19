import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../models/message_dto.dart';
import '../../models/session_dto.dart';
import '../contract/smart_coach_local_data_source.dart';

@Injectable(as: SmartCoachLocalDataSource)
class SmartCoachLocalDataSourceImpl implements SmartCoachLocalDataSource {
  final Box<SessionDto> _sessionBox;

  SmartCoachLocalDataSourceImpl(this._sessionBox);

  @override
  Future<void> saveSmartCoachMessage(
    String userMessage,
    String smartCoachMessage,
    String title,
    String sessionId,
  ) async {
    // check if session exists
    var sessionDto = _sessionBox.get(sessionId);

    if (sessionDto != null) {
      // update existing session
      sessionDto.timestamp = DateTime.now();
      sessionDto.title = title;
      sessionDto.messages.add(
        MessageDto(
          smartCoachMessage: smartCoachMessage,
          userMessage: userMessage,
          timestamp: DateTime.now(),
        ),
      );
      await _sessionBox.put(sessionId, sessionDto);
    } else {
      // create new session
      sessionDto = SessionDto(
        sessionId: sessionId,
        title: title,
        messages: [
          MessageDto(
            smartCoachMessage: smartCoachMessage,
            userMessage: userMessage,
            timestamp: DateTime.now(),
          ),
        ],
        timestamp: DateTime.now(),
      );
      await _sessionBox.put(sessionId, sessionDto);
    }
  }

  @override
  Future<Map<String, SessionDto>> getAllConversations() async {
    final Map<String, SessionDto> sessions = {
      for (var key in _sessionBox.keys)
        if (_sessionBox.get(key) != null) key: _sessionBox.get(key)!,
    };

    final sortedEntries = sessions.entries.toList()
      ..sort((a, b) => b.value.timestamp.compareTo(a.value.timestamp));

    return Map.fromEntries(sortedEntries);
  }

  @override
  Future<void> deleteConversation(String sessionId) async {
    await _sessionBox.delete(sessionId);
  }

  @override
  Future<List<MessageDto>> getLastTenMessagesInConversationBySessionId(
    String sessionId,
  ) async {
    final sessionDto = _sessionBox.get(sessionId);
    if (sessionDto == null || sessionDto.messages.isEmpty) {
      return [];
    }
    final messages = sessionDto.messages
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return messages.take(10).toList();
  }
}
