import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/utils/datasource_excution/api_result.dart';
import '../../../../../domain/smart_coach/entity/session_entity.dart';
import '../../../../../domain/smart_coach/entity/smart_coach_message_entity.dart';
import '../../../../../domain/smart_coach/entity/user_message_entity.dart';
import '../../../../../domain/smart_coach/use_case/ask_smart_coach_use_case.dart';
import '../../../../../domain/smart_coach/use_case/delete_conversation_use_case.dart';
import '../../../../../domain/smart_coach/use_case/get_all_conversation_use_case.dart';
import '../message.dart';
import '../smart_coach_message.dart';
import '../user_message.dart';

part 'smart_coach_state.dart';

@injectable
class SmartCoachCubit extends Cubit<SmartCoachState> {
  final AskSmartCoachUseCase _askSmartCoachUseCase;
  final GetAllConversationUseCase _getAllConversationUseCase;
  final DeleteConversationUseCase _deleteConversationUseCase;
  final PageController pageController = PageController();
  final TextEditingController messageController = TextEditingController();
  late SmartCoachMessageEntity smartCoachMessageEntity;
  final ScrollController scrollController = ScrollController();
  String sessionId;
  Map<String, SessionEntity> sessions = {};

  SmartCoachCubit(
    this._askSmartCoachUseCase,
    this._getAllConversationUseCase,
    this._deleteConversationUseCase,
  ) : sessionId = const Uuid().v4(),
      super(const SmartCoachState());

  @override
  Future<void> close() {
    messageController.dispose();
    scrollController.dispose();
    pageController.dispose();
    return super.close();
  }

  void doIntent(SmartCoachAction action) {
    switch (action) {
      case ChangePageAction():
        {
          _changePage(action.index);
        }
      case ValidateMessageAction():
        {
          _validateMessage();
        }
      case AskSmartCoachAction():
        {
          _askSmartCoach(action.message);
        }
      case GetAllConversationsAction():
        {
          _getAllConversations();
        }
      case StartNewChatAction():
        {
          _startNewChat();
        }
      case GetOldConversation():
        {
          _getConversation(action.conversationId);
        }
      case DeleteConversationAction():
        {
          _deleteConversation(action.conversationId);
        }
    }
  }

  void _changePage(int index) {
    final newIndex = index;

    if (newIndex < 0 || newIndex >= 2) return;

    pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(state.copyWith(currentPageIndex: newIndex));
  }

  void _validateMessage() {
    final isValid = messageController.text.trim().isNotEmpty;
    if (isValid == state.isValidMessage) return;
    emit(state.copyWith(isValidMessage: isValid));
  }

  void _scrollToLastMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _askSmartCoach(String message) async {
    final userMessage = UserMessage(message);
    emit(
      state.copyWith(
        baseState: BaseLoadingState(),
        messages: [...state.messages, userMessage],
      ),
    );
    _scrollToLastMessage();
    var result = await _askSmartCoachUseCase(
      UserMessageEntity(message: message),
      sessionId,
    );
    switch (result) {
      case SuccessResult<SmartCoachMessageEntity>():
        {
          final coachMessage = SmartCoachMessage(result.data.content);
          emit(
            state.copyWith(
              baseState: BaseSuccessState(),
              messages: [...state.messages, coachMessage],
              isValidMessage: false,
            ),
          );
          messageController.clear();
          _scrollToLastMessage();
        }
      case FailureResult<SmartCoachMessageEntity>():
        {
          emit(
            state.copyWith(
              baseState: BaseErrorState(
                errorMessage: result.exception.toString(),
                exception: result.exception,
              ),
            ),
          );
        }
    }
  }

  Future<void> _getAllConversations() async {
    emit(state.copyWith(getAllConversations: BaseLoadingState()));
    var result = await _getAllConversationUseCase();
    switch (result) {
      case SuccessResult<Map<String, SessionEntity>>():
        {
          sessions = result.data;
          emit(state.copyWith(getAllConversations: BaseSuccessState()));
        }
      case FailureResult<Map<String, SessionEntity>>():
        {
          emit(
            state.copyWith(
              getAllConversations: BaseErrorState(
                errorMessage: result.exception.toString(),
                exception: result.exception,
              ),
            ),
          );
        }
    }
  }

  Future<void> _getConversation(String conversationId) async {
    emit(state.copyWith(getConversation: BaseLoadingState()));
    SessionEntity? session;
    if (sessions.isNotEmpty) {
      session = sessions[conversationId];

      if (session != null) {
        sessionId = conversationId;
        final messages = session.messages
            .expand(
              (m) => [
                UserMessage(m.userMessage),
                SmartCoachMessage(m.smartCoachMessage),
              ],
            )
            .toList();

        emit(
          state.copyWith(
            getConversation: BaseSuccessState(),
            messages: messages,
            isValidMessage: false,
          ),
        );
        _scrollToLastMessage();
      }
    }

    if (session == null) {
      emit(
        state.copyWith(
          getConversation: BaseErrorState(
            errorMessage: 'Conversation not found',
          ),
        ),
      );
    }
  }

  Future<void> _deleteConversation(String conversationId) async {
    await _getConversation(conversationId);
    emit(state.copyWith(deleteConversation: BaseLoadingState()));
    var result = await _deleteConversationUseCase(conversationId);
    switch (result) {
      case SuccessResult<void>():
        {
          sessions.remove(conversationId);
          emit(
            state.copyWith(
              deleteConversation: BaseSuccessState(),
              messages: [],
              isValidMessage: false,
              baseState: null,
            ),
          );
        }
      case FailureResult<void>():
        {
          emit(
            state.copyWith(
              deleteConversation: BaseErrorState(
                errorMessage: result.exception.toString(),
                exception: result.exception,
              ),
            ),
          );
        }
    }
  }

  Future<void> _startNewChat() async {
    sessionId = const Uuid().v4();
    messageController.clear();
    emit(state.copyWith(messages: [], isValidMessage: false, baseState: null));
  }
}
