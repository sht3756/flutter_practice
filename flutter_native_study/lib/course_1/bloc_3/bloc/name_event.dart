part of 'name_bloc.dart';

sealed class NameEvent {}

final class NameChanged extends NameEvent {
  final String name;

  NameChanged({required this.name});
}

final class NameSubmitted extends NameEvent {
  NameSubmitted();
}
