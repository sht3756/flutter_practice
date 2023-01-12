import 'package:authentication_study/common/const/data.dart';

class DataUtils {
  static pathToUrl(String value) {
    // value 는 thumbUrl 이다.
    return 'http://$ip$value';
  }
}