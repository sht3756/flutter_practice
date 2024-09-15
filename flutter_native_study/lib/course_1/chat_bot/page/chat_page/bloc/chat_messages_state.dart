part of 'chat_messages_bloc.dart';

class ChatMessagesState {
  final ChatItemModel? chatItem;
  final List<MessageItemModel> messages;
  final bool isLoading;

  ChatMessagesState({
    this.chatItem,
    this.messages = const [],
    this.isLoading = false,
  });

  ChatMessagesState copyWith({
    ChatItemModel? chatItem,
    List<MessageItemModel>? messages,
    bool? isLoading,
  }) {
    return ChatMessagesState(
      chatItem: chatItem ?? this.chatItem,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final class ChatMessagesLoadingState extends ChatMessagesState {
  ChatMessagesLoadingState();
}
