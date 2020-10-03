import 'package:flutter/material.dart';
import 'package:flutter_app/database_screen.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/modules/counter/counter_screen.dart';
import 'package:flutter_app/modules/counter/counter_screen2.dart';

class BottomModel
{
  final String title;
  final IconData icon;

  BottomModel({this.title, this.icon});
}

class BottomScreen extends StatefulWidget
{
  @override
  _BottomScreenState createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen>
{
  int selectedIndex = 0;

  List<Widget> myWidgets = [
    CounterScreen(),
    HomeScreen(),
    CounterScreen2(),
  ];

  List<BottomModel> myBottomNav = [
    BottomModel(
      title: 'Bottom 1',
      icon: Icons.ac_unit,
    ),
    BottomModel(
      title: 'Bottom 2',
      icon: Icons.add,
    ),
    BottomModel(
      title: 'Bottom 3',
      icon: Icons.error_outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myWidgets[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index)
        {
          setState(()
          {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        items: [
          ...myBottomNav.map((e) => BottomNavigationBarItem(
            icon: Icon(e.icon),
            title: Text(e.title),
          )),
        ],
      ),
    );
  }
}