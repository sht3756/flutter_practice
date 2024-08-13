import 'package:flutter/material.dart';

class SliverAppBarWithTabExample extends StatelessWidget {
  const SliverAppBarWithTabExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverAppBar(
                floating: true,
                pinned: true,
                title: Text('SliverAppbar with Tabs'),
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.info), text: 'tab1'),
                    Tab(icon: Icon(Icons.lightbulb_outline), text: 'tab2'),
                    Tab(icon: Icon(Icons.add), text: 'tab3'),
                  ],
                ),
              )
            ],
            body: const TabBarView(
              children: [
                Center(child: Text('Tab1s Content')),
                Center(child: Text('Tab2s Content')),
                Center(child: Text('Tab3s Content')),
              ],
            ),
          ),
        ));
  }
}
