import 'package:flutter/material.dart';
import 'package:flutter_app/database_screen.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/home_bottom.dart';
import 'package:flutter_app/home_drawer.dart';
import 'package:flutter_app/modules/counter/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        child: BottomScreen(),
      ),
    );
  }
}