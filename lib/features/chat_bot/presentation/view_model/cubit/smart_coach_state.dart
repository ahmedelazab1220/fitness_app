part of 'smart_coach_cubit.dart';

class SmartCoachState extends Equatable {
  final int? currentPageIndex;
  final BaseState? baseState;
  final BaseState? getAllConversations;
  final BaseState? getConversation;
  final BaseState? deleteConversation;
  final bool? isValidMessage;
  final List<Message> messages;

  const SmartCoachState({
    this.currentPageIndex = 0,
    this.baseState,
    this.getAllConversations,
    this.getConversation,
    this.deleteConversation,
    this.isValidMessage = false,
    this.messages = const [],
  });

  SmartCoachState copyWith({
    int? currentPageIndex,
    BaseState? baseState,
    BaseState? getAllConversations,
    BaseState? getConversation,
    BaseState? deleteConversation,
    bool? isValidMessage,
    List<Message>? messages,
  }) {
    return SmartCoachState(
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      baseState: baseState ?? this.baseState,
      getConversation: getConversation ?? this.getConversation,
      getAllConversations: getAllConversations ?? this.getAllConversations,
      isValidMessage: isValidMessage ?? this.isValidMessage,
      messages: messages ?? this.messages,
      deleteConversation: deleteConversation ?? this.deleteConversation,
    );
  }

  @override
  List<Object?> get props => [
    currentPageIndex,
    baseState,
    isValidMessage,
    messages,
    getAllConversations,
    getConversation,
    deleteConversation,
  ];
}

sealed class SmartCoachAction {}

final class ChangePageAction extends SmartCoachAction {
  final int index;
  ChangePageAction({required this.index});
}

final class AskSmartCoachAction extends SmartCoachAction {
  final String message;
  AskSmartCoachAction({required this.message});
}

final class ValidateMessageAction extends SmartCoachAction {}

final class GetAllConversationsAction extends SmartCoachAction {}

final class StartNewChatAction extends SmartCoachAction {}

final class DeleteConversationAction extends SmartCoachAction {
  final String conversationId;
  DeleteConversationAction({required this.conversationId});
}

final class GetOldConversation extends SmartCoachAction {
  final String conversationId;
  GetOldConversation({required this.conversationId});
}
