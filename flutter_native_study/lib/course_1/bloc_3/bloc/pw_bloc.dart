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

  void _onPwChanged(PwChanged event, Emitter<PwState> state) {
  }

  void _onConfirmPwChanged(ConfirmPwChanged event, Emitter<PwState> state) {}
}
