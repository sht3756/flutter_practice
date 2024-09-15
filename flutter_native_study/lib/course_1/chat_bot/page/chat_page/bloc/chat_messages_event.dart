part of 'chat_messages_bloc.dart';


sealed class ChatMessagesEvent {
  const ChatMessagesEvent();
}

class ChatMessagesInitialEvent extends ChatMessagesEvent {
  final ChatItemModel chatItem;

  ChatMessagesInitialEvent(this.chatItem);
}

class ChatMessagesAddEvent extends ChatMessagesEvent {
  final String message;

  ChatMessagesAddEvent(this.message);
}