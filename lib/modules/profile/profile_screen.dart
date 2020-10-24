import 'package:conditional_builder/conditional_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/modules/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget
{
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
{
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ),
  );
  var data;

  @override
  void initState()
  {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: ConditionalBuilder(
        condition: data != null,
        builder: (context) => Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${data['name']}',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                '${data['email']}',
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
                    logOut();
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
  }

  getProfile() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');

    dio.options.headers = {
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization': token,
    };
    
    await dio.get('profile').then((response)
    {
      data = response.data['data'];
      setState(() {

      });
    });
  }

  logOut() async
  {
    await SharedPreferences.getInstance().then((value) {
      value.setString('token', '').then((value)
      {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
      });
    });
  }
}
