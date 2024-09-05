// 비동기 작업을 관리하기 위해 사용
// AsyncNotifier 클래스를 확장하는 사용자 정의 객체와 함께 사용
// 데이터 로드, 로드 완료, 에러 발생과 같은 다양한 비동기 상태를 UI 에서 쉽게 관리

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  final String name;

  Product(this.name);
}

Future<List<Product>> fetchProducts() async {
  await Future.delayed(const Duration(seconds: 2));

  // api 처리, 값을 받아오고 처리한 후, return 으로 반환하지만,
  // 여기선 값을 받아왔다 가정하고, List String 객체를 반환!
  return [
    Product('Product 1'),
    Product('Product 2'),
    Product('Product 3'),
  ];
}

class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build() async {
    try {
      List<Product> products = await fetchProducts();

      return products;
    } catch (e) {
      rethrow;
    }
  }
}

final productProvider = AsyncNotifierProvider<ProductNotifier, List<Product>>(
    () => ProductNotifier());

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Center(
        child: productList.when(
          data: (products) => ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(products[index].name),
            ),
          ),
          error: (error, stackTrace) => Text('Error : $error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
