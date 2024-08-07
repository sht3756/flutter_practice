import 'package:flutter_bloc/flutter_bloc.dart';

enum MallType {market, beauty}

class MallTypeCubit extends Cubit<MallType> {
  MallTypeCubit():super(MallType.market);
  void changeIndex(int index) => emit(MallType.values[index]);
}

extension MallTypeX on MallType {
  String get toName {
    switch(this) {
      case MallType.market :
        return '마켓';
      case MallType.beauty:
        return '뷰티';
    }
  }

  bool get isMarket => this== MallType.market;
  bool get isBeauty => this== MallType.beauty;
}