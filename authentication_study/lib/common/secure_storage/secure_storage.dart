import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 토큰을 저장할 스토리지 생성
// Provider 를 통해서 FlutterSecureStorage() 함수를 리턴한다.
final secureStorageProvider =
    Provider<FlutterSecureStorage>((ref) => FlutterSecureStorage());
