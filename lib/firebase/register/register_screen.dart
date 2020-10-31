import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatelessWidget
{
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'username'
              ),
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'email'
              ),
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'password'
              ),
            ),
            TextFormField(
              controller: confirmPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'confirm password'
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              height: 40.0,
              color:Colors.blue,
              child: FlatButton(
                  onPressed: ()
                  {
                    String name = nameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;
                    String cPassword = confirmPasswordController.text;

                    if(name.isEmpty || email.isEmpty)
                    {
                      Toast.show('please enter a valid data', context);
                      return;
                    }

                    if(password != cPassword)
                    {
                      Toast.show('passwords don\'t matching', context);
                      return;
                    }

                    createUser(name, email, password, context);
                  },
                  child: Text(
                      'register'.toUpperCase(),
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

  createUser(String name, String email, String password, context) async
  {
    FirebaseAuth
        .instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((createdUser)
        {
          Toast.show(createdUser.user.uid, context);
          print(createdUser.user.uid);
          createdUser.user.sendEmailVerification();
        })
        .catchError((e)
        {
          switch(e.toString())
          {
            case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
              Toast.show('any thing', context);
              break;
            case 'account':
              Toast.show('any thing', context);
              break;
          }
        });
  }
}
