import 'package:flutter/material.dart';
import 'package:flutter_app/database_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.red,
              indicatorWeight: 6.0,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.red,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                        ),
                        Text(
                          'Abdullah Mansour',
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                        ),
                        Text(
                          'Abdullah Mansour',
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                        ),
                        Text(
                          'Abdullah Mansour',
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                        ),
                        Text(
                          'Abdullah Mansour',
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Text('Tab 2'),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  DatabaseScreen(
                    showAppBar: false,
                  ),
                  Center(
                    child: Text('Tab 2'),
                  ),
                  Center(
                    child: Text('Tab 2'),
                  ),
                  Center(
                    child: Text('Tab 2'),
                  ),
                  Center(
                    child: Text('Tab 2'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
