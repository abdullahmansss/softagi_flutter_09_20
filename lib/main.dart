import 'package:flutter/material.dart';
import 'package:flutter_app/counter_screen.dart';
import 'package:flutter_app/database_screen.dart';
import 'package:flutter_app/login_screen.dart';
import 'package:flutter_app/order_summary.dart';
import 'package:flutter_app/single_product.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DatabaseScreen(),
    );
  }
}