import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'list',
        ),
      ),
      body: ListView.separated(
          itemBuilder: (ctx, index) => buildItem(),
          separatorBuilder: (ctx, index) => Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey,
          ),
          itemCount: 10,
      ),
    );
  }

  Widget buildItem() => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.blue,
          child: Text(
            '1',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Abdullah Mansour Ali',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '01115342559',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
