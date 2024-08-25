import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_study/course_1/bloc_3/regx.dart';

part 'email_event.dart';

part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(EmailState(email: '', isValid: false)) {
    on<EmailChanged>(_onEmailChanged);
    on<EmailSubmitted>(_onEmailSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<EmailState> emit) {
    final email = event.email;
    final isValid = emailRegExp.hasMatch(email);
    emit(EmailState(email: email, isValid: isValid));
  }

  void _onEmailSubmitted(EmailSubmitted event, Emitter<EmailState> emit) {
    emit( EmailState(email: '', isValid: false));
  }
}
