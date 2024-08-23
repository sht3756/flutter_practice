part of 'email_bloc.dart';

sealed class EmailEvent {

}

final class EmailChanged extends EmailEvent {
  final String email;

  EmailChanged(this.email);
}