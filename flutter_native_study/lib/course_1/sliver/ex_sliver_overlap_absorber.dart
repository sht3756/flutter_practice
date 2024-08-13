import 'package:flutter/material.dart';

class SliverOverlapAbsorberExample extends StatelessWidget {
  const SliverOverlapAbsorberExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SliverOverlapAbsorber'),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Tab1',
            ),
            Tab(
              text: 'Tab2',
            ),
          ]),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const Text('Nested Scroll View'),
                pinned: true,
                expandedHeight: 150.0,
                forceElevated: innerBoxIsScrolled,
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildTabView('Tab 1 Content'),
              _buildTabView('Tab 2 Content'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabView(String text) => Builder(
        builder: (context) => CustomScrollView(
          slivers: [
            SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 20,
                (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
              ),
            ),
          ],
        ),
      );
}
