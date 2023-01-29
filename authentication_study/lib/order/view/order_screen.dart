import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // final state = ref.watch(provider);

    return Container(child: Center(child: Text('주문'),),);
  }
}
