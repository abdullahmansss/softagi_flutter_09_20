import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modules/news/cubit/cubit.dart';
import 'package:flutter_app/modules/news/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatelessWidget
{
  final bool category;

  const NewsScreen({this.category});

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          var list = NewsCubit.get(context).postsList;
          var sports = NewsCubit.get(context).sportsList;

          return Scaffold(
            appBar: AppBar(
              title: Text('News'),
            ),
            body: ConditionalBuilder(
              condition: state is! NewsLoadingState,
              builder: (ctx) => ListView.separated(
                itemBuilder: (context, index) => buildItem(context, category ? list[index] : sports[index]),
                separatorBuilder: (context, index) => Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey,
                ),
                itemCount: category ? list.length : sports.length,
              ),
              fallback: (ctx) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  Widget buildItem(context, post) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.blue,
          child: Text(
            '7',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${post['title']}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${post['description']}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}