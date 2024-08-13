import 'package:flutter/material.dart';

class FutureBuilderExample1 extends StatelessWidget {
  const FutureBuilderExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder Demo'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error : ${snapshot.error}');
            } else {
              return Text(snapshot.data ?? 'empty');
            }
          },
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return '데이터 로드 완료';
  }
}
