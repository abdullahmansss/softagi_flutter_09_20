
import 'package:conditional_builder/conditional_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/modules/profile/profile_screen.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget
{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
      headers:
      {
        'lang':'en',
        'Content-Type':'application/json',
      },
    ),
  );

  @override
  void initState()
  {
    checkSigning();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              width: double.infinity,
              height: 40.0,
              color: Colors.blue,
              child: FlatButton(
                onPressed: (){
                  login(emailController.text, passwordController.text);
                },
                child: Text(
                  'login'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkSigning() async
  {
    await SharedPreferences.getInstance().then((value)
    {
      if(value.getString('token').length != 0)
      {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ));
      }
    });
  }

  login(email, password) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
    });

    await dio.post('login', data: formData).then((response) async
    {
      await prefs.setString('token', response.data['data']['token']).then((value)
      {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ));
      });

      return null;
    });
  }
}
