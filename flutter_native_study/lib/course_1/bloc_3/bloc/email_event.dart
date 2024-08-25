part of 'email_bloc.dart';

sealed class EmailEvent {

}

final class EmailChanged extends EmailEvent {
  final String email;

  EmailChanged(this.email);
}

final class EmailSubmitted extends EmailEvent {
  EmailSubmitted();
}