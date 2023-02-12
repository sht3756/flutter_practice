import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  static List<Widget> pages = <Widget>[
    Container(color: Colors.redAccent),
    Container(color: Colors.greenAccent),
    Container(color: Colors.orangeAccent)
  ];

  void _onItemClick(int index) {
    _selectedIndex = index;
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Fooderlich',
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          )),
      // TODO: Style the body text
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemClick,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel), label: 'Card'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'Card'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'Card'),
        ],
      ),
    );
  }
}
