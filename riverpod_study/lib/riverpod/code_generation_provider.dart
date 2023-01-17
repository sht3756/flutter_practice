import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1) 어떤 Provider 를 사용할지 고민 할 필요없게
// Provider, FutureProvider, StreamProvider
// StateNotifierProvider

final _testProvider = Provider<String>((ref) => 'Hello Code Generation');
/* 위의 코드와 아래 코드는 같다.
함수 형식으로 작성하니깐 직관성이 높고,
코드 제너레이션을통해서 여러가지 추가 기능을 제공 받을 수 있다.
 */
@riverpod
String gState(GStateRef ref) {
  return 'Hello Code Generation';
}

// 2) Parameter > family Modifier 파라미터를 일반 함수처럼 사용할 수 있도록
// 결론 : 이 2가지 문제를 해결하기 위해서 code_generation 이 riverPod 에 추가가 된 것이다.