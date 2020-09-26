import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget
{
  final Map userInfo;

  const UserInfo({this.userInfo});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            '${userInfo['id']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          Text(
            '${userInfo['name']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          Text(
            '${userInfo['phone']}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
