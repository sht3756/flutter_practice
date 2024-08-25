part of 'pw_bloc.dart';

sealed class PwEvent {
  const PwEvent();
}

final class PwChanged extends PwEvent {
  final String pw;

  PwChanged(this.pw);

}

final class ConfirmPwChanged extends PwEvent {
  final String confirmPw;

  ConfirmPwChanged(this.confirmPw);

}

final class PwSubmitted extends PwEvent {
  PwSubmitted();
}