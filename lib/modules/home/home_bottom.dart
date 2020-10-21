import 'package:flutter/material.dart';
import 'package:flutter_app/database_screen.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/modules/counter/counter_screen.dart';
import 'package:flutter_app/modules/counter/counter_screen2.dart';
import 'package:flutter_app/modules/news/cubit/cubit.dart';
import 'package:flutter_app/modules/news/cubit/states.dart';
import 'package:flutter_app/modules/news/news_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomModel
{
  final String title;
  final IconData icon;

  BottomModel({this.title, this.icon});
}

class BottomScreen extends StatelessWidget
{
  List<BottomModel> myBottomNav = [
    BottomModel(
      title: 'Business',
      icon: Icons.ac_unit,
    ),
    BottomModel(
      title: 'Sports',
      icon: Icons.add,
    ),
  ];

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Scaffold(
          body: NewsCubit.get(context).myWidgets[NewsCubit.get(context).selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              NewsCubit.get(context).changeBottom(index);

              if(index == 0)
              {
                if(NewsCubit.get(context).postsList.length == 0)
                  NewsCubit.get(context).getData('business');
              }
              else
                {
                  if(NewsCubit.get(context).sportsList.length == 0)
                    NewsCubit.get(context).getData('sports');
                }
            },
            currentIndex: NewsCubit.get(context).selectedIndex,
            items: [
              ...myBottomNav.map((e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.title,
              )),
            ],
          ),
        );
      },
    );
  }
}