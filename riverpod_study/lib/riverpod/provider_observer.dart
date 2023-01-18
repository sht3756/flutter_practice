import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  // Provider 가 업데이트 되었을때
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    print(
      '[Provider Updated] provider: $provider / pv: $previousValue / nv: $newValue',
    );
  }

  // Provider 가 추가 되었을때
  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    print(
      '[Provider Added] provider: $provider / value: $value',
    );
  }

  // Provider 가 종료 되었을때
  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    print(
      '[Provider Disposed] provider: $provider',
    );
  }
}
