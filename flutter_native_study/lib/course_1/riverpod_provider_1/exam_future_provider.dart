import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String> fetchUser() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Harry';
}

final userProvider = FutureProvider<String>((ref) async {
  return fetchUser();
});


class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFuture = ref.watch(userProvider);
    return userFuture.when(data: (data) => Text('User : $data'), error: (error, stackTrace) => Text('Error : $error'), loading: () => const CircularProgressIndicator());
  }
}

