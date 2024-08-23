import 'package:flutter_bloc/flutter_bloc.dart';

part 'name_event.dart';

part 'name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  NameBloc() : super(NameState(name: '', isValid: false)) {
    on<NameChanged>(_onNameChanged);
  }

  void _onNameChanged(NameChanged event, Emitter<NameState> emit) {
    final name = event.name;
    final isValid = name.length >= 2;
    emit(NameState(name: name, isValid: isValid));
  }
}
