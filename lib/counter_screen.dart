import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CounterScreen extends StatefulWidget
{
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>
{
  int i = 0;

  @override
  Widget build(BuildContext context)
  {
    var usernameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter'
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/man.png'),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  i++;
                });
              },
              child: Icon(
                Icons.add,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              i.toString(),
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  i--;
                });
              },
              child: Icon(
                Icons.remove,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'enter your name',
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: ()
              {
                Toast.show("Toast plugin app", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              },
              child: Icon(
                Icons.list,
              ),
            ),
            Text(
              usernameController.text
            ),
          ],
        ),
      ),
    );
  }
}