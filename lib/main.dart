import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firebase/register/register_screen.dart';
import 'package:flutter_app/modules/home/home_bottom.dart';
import 'package:flutter_app/modules/login/login_screen.dart';
import 'package:flutter_app/modules/news/cubit/cubit.dart';
import 'package:flutter_app/modules/news/news_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => NewsCubit()..getData('business'),
        child: RegisterScreen(),
      ),
    );
  }
}