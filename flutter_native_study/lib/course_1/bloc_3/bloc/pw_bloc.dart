import 'package:flutter_bloc/flutter_bloc.dart';

part 'pw_event.dart';

part 'pw_state.dart';

class PwBloc extends Bloc<PwEvent, PwState> {
  PwBloc()
      : super(PwState(
          pw: '',
          confirmPw: '',
          isPwValid: false,
          isConfirmPwValid: false,
        )) {
    on<PwChanged>(_onPwChanged);
    on<ConfirmPwChanged>(_onConfirmPwChanged);
  }

  void _onPwChanged(PwChanged event, Emitter<PwState> emit) {
    final newPw = event.pw;
    final newState = state.copyWith(
      pw: newPw,
      isPwValid: _isValidPw(newPw),
      isConfirmPwValid: _isValidPw(state.confirmPw) && newPw == state.confirmPw
    );
    emit(newState);
  }

  void _onConfirmPwChanged(ConfirmPwChanged event, Emitter<PwState> emit) {
    final newConfirmPw = event.confirmPw;
    final newState = state.copyWith(
      confirmPw: newConfirmPw,
      isConfirmPwValid: _isValidPw(newConfirmPw) && newConfirmPw == state.pw,
    );
    emit(newState);
  }

  bool _isValidPw(String pw) {
    return pw.length >= 8;
  }
}
