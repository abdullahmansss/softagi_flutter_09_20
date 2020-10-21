import 'package:flutter/material.dart';
import 'package:flutter_app/database_screen.dart';
import 'package:flutter_app/modules/home/home_bottom.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer>
{
  int selectedIndex = 0;

  List<Widget> myWidgets = [
    BottomScreen(),
    DatabaseScreen(
      showAppBar: true,
    ),
    DatabaseScreen(
      showAppBar: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Drawer'
        ),
      ),
      body: myWidgets[selectedIndex],
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: null,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (ctx, index) => ListTile(
                  selected: (selectedIndex == index),
                  onTap: ()
                  {
                    setState(() {
                      selectedIndex = index;
                      Navigator.pop(ctx);
                    });
                  },
                  title: Text(
                    'item ${index + 1}'
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
                separatorBuilder: (ctx, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
