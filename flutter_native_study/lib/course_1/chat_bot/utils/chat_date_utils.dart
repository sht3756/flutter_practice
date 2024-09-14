import 'package:intl/intl.dart';

class ChatDateUtils {
  // 채팅방 타이틀
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  // 채팅방 내의 날짜 표시
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy년 MM월 dd일 EEEE').format(dateTime);
  }

  // 채팅방 내의 말풍선의 시간 표시
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}