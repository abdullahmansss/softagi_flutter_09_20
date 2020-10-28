import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/modules/login/cubit/cubit.dart';
import 'package:flutter_app/modules/login/cubit/states.dart';
import 'package:flutter_app/modules/profile/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget
{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState()
  {
    checkSigning();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state)
        {
          if(state is LoginStateSuccess)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ));
          }
          if(state is LoginStateError)
          {
            Toast.show(state.error, context, duration: Toast.LENGTH_LONG);
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
            ),
            body: ConditionalBuilder(
              builder: (BuildContext context) => Padding(
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
                        onPressed: ()
                        {
                          LoginCubit.get(context).login(emailController.text, passwordController.text);
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
              fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),
              condition: state is! LoginStateLoading,
            ),
          );
        },
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
}
