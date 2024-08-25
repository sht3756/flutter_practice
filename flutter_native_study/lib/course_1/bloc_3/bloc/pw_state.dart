part of 'pw_bloc.dart';

class PwState {
  final String pw;
  final String confirmPw;
  final bool isPwValid;
  final bool isConfirmPwValid;

  PwState({
    required this.pw,
    required this.confirmPw,
    required this.isPwValid,
    required this.isConfirmPwValid,
  });

  PwState copyWith({
    String? pw,
    String? confirmPw,
    bool? isPwValid,
    bool? isConfirmPwValid,
  }) {
    return PwState(
      pw: pw ?? this.pw,
      confirmPw: confirmPw ?? this.confirmPw,
      isPwValid: isPwValid ?? this.isPwValid,
      isConfirmPwValid: isConfirmPwValid ?? this.isConfirmPwValid,
    );
  }
}
