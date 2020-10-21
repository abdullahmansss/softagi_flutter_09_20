import 'package:flutter/material.dart';
import 'package:flutter_app/modules/news/cubit/states.dart';
import 'package:flutter_app/modules/news/news_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List postsList = [];

  List sportsList = [];

  int selectedIndex = 0;

  List<Widget> myWidgets = [
    NewsScreen(
      category: true,
    ),
    NewsScreen(
      category: false,
    ),
  ];

  getData(String category) async
  {
    emit(NewsLoadingState());

    switch(category)
    {
      case 'business':
        var url = 'http://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca';
        var jsonResponse = await http.get(url);

        Map response = json.decode(jsonResponse.body);
        postsList = RecentPostsMap.get(response).getArticles();

        break;
      case 'sports':
        var url = 'http://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=65f7f556ec76449fa7dc7c0069f040ca';
        var jsonResponse = await http.get(url);

        Map response = json.decode(jsonResponse.body);
        sportsList = RecentPostsMap.get(response).getArticles();

        break;
    }
    emit(NewsSuccessState());
  }

  changeBottom(index)
  {
    selectedIndex = index;
    emit(NewsChangeBottomState());
  }
}

class RecentPostsMap
{
  final Map dataFromApi;

  RecentPostsMap(this.dataFromApi);

  static RecentPostsMap get(Map stringFromApi)
  {
    return RecentPostsMap(stringFromApi);
  }

  List getArticles() => dataFromApi['articles'];
}