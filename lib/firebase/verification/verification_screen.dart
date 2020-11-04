import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class VerificationScreen extends StatefulWidget
{
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Column(
        children: [
          Text(
            'please check your email to verify...',
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            color:Colors.blue,
            child: FlatButton(
              onPressed: ()
              {
                checkVerification(context);
              },
              child: Text(
                'next'.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  checkVerification(context)
  {
    if(FirebaseAuth.instance.currentUser.emailVerified)
    {
      Toast.show('done', context);
    } else
      {
        Toast.show('nooooo', context);
      }
  }
}
