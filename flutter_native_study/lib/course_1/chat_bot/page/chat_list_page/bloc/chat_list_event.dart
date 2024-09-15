part of 'chat_list_bloc.dart';

abstract class ChatListEvent {
  const ChatListEvent();
}

final class ChatListInitEvent extends ChatListEvent {
  const ChatListInitEvent();
}

final class ChatListAddEvent extends ChatListEvent {
  const ChatListAddEvent();
}

final class ChatListRemoveEvent extends ChatListEvent {
  final int index;
  const ChatListRemoveEvent(this.index);
}
