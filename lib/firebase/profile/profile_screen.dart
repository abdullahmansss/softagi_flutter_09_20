import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:toast/toast.dart';

class ProfileScreen extends StatefulWidget
{
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
{
  Map data;
  File image;

  bool offers = false, items = false;

  @override
  void initState()
  {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    receiveNotifications();

    return Scaffold(
      appBar: AppBar(),
      body: ConditionalBuilder(
        condition: data != null,
        builder: (context) => Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: ()
                {
                  selectImage();
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: image != null ? FileImage(image) : NetworkImage(data['image']),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                data['username'],
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              Text(
                data['email'],
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text(
                data['uId'],
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Items',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    CupertinoSwitch(
                      value: items,
                      onChanged: (value)
                      {
                        setState(()
                        {
                          items = value;
                          if(value)
                            FirebaseMessaging().subscribeToTopic('itemsTopic');
                          else
                            FirebaseMessaging().unsubscribeFromTopic('itemsTopic');
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Offers',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    CupertinoSwitch(
                      value: offers,
                      onChanged: (value)
                      {
                        setState(() {
                          offers = value;

                          if(value)
                            FirebaseMessaging().subscribeToTopic('offersTopic');
                          else
                            FirebaseMessaging().unsubscribeFromTopic('offersTopic');

                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 40.0,
                  color: Colors.blue,
                  child: FlatButton(
                    onPressed: ()
                    {
                      if(image != null)
                        uploadImage();
                      else
                        Toast.show('please select image', context);
                    },
                    child: Text(
                      'upload image'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  receiveNotifications()
  {
    FirebaseMessaging().configure(
      onMessage: (msg)
      {
        Toast.show(msg.toString(), context);
        print('${msg['notification']['title']}');
        print('${msg['data']['offers']}');
        print('${msg['data']['items']}');

        setState(()
        {
          offers = msg['data']['offers'] == 'true' ? true : false;
          items = msg['data']['items'] == 'true' ? true : false;
        });
      },
    );
  }

  selectImage()
  {
    ImagePicker().getImage(source: ImageSource.gallery).then((value)
    {
      image = File(value.path);

      setState(()
      {

      });
    });
  }

  getData()
  {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .listen((event) {
      data = event.data();

      setState(() {

      });
    });

    // users
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .get()
    //     .then((value)
    // {
    //   data = value.data();
    //
    //   setState(() {
    //
    //   });
    // })
    //     .catchError((e){});
  }

  //Uri.file(file.path).pathSegments.last

  uploadImage()
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(image.path).pathSegments.last}')
        .putFile(image).onComplete.then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        CollectionReference users = FirebaseFirestore.instance.collection('users');

        users
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({
          'image': value.toString(),
        })
            .then((value)
        {
          //getData();
        })
            .catchError((error)
        {
          print(error.toString());
        });
      });
    });
  }
}
