import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int> {
  // 초기값 0
  CounterCubit() : super(0);

  // 증가
  void increment() => emit(state + 1);

  // 감소
  void decrement() => emit(state - 1);
}
