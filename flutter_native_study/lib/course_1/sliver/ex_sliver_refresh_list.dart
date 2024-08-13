import 'package:flutter/material.dart';

class SliverRefreshListExample extends StatefulWidget {
  const SliverRefreshListExample({super.key});

  @override
  State<SliverRefreshListExample> createState() =>
      _SliverRefreshListExampleState();
}

class _SliverRefreshListExampleState extends State<SliverRefreshListExample> {
  Future<void> _handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverListWithRefresh'),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 30,
                  (context, index) => ListTile(
                        title: Text('Item $index'),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
