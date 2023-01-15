import 'package:flutter_riverpod/flutter_riverpod.dart';

final multipleFutureProvider = FutureProvider<List<int>>(
  (ref) async {
    await Future.delayed(
      Duration(seconds: 2),
    );

    // return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    throw Exception('에러입니다.');
  },

);
