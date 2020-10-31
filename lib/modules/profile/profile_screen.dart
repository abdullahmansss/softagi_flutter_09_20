import 'dart:convert';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/modules/login/login_screen.dart';
import 'package:flutter_app/modules/profile/cubit/cubit.dart';
import 'package:flutter_app/modules/profile/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget
{
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileCubit()..getProfile(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileStatesLogout) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          var data = ProfileCubit.get(context).data;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
            ),
            body: ConditionalBuilder(
              condition: state is! ProfileStatesLoading,
              builder: (context) => Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: ()
                      {
                        ProfileCubit.get(context).pickImage();
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: ProfileCubit.get(context).file != null ? FileImage(ProfileCubit.get(context).file) : NetworkImage('https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512__340.jpg'),
                          ),
                          CircleAvatar(
                            radius: 15.0,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.camera_alt,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '${data['name']}',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      response.length != 0 ? '${response[0]['name']}' : '',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      '${data['phone']}',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      '${data['id']}',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: ()
                      {
                        //ProfileCubit.get(context).logOut();
                        getQuranData();
                      },
                      child: Text(
                        'logout'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  List response = [];

  getQuranData() async
  {
    var url = 'http://api.quran-tafseer.com/quran/';
    var jsonResponse = await http.get(url);

    response = json.decode(jsonResponse.body);

    print(response[0]['index']);
    print(response[0]['name']);

    setState(() {

    });
  }
}