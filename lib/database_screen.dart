import 'package:flutter/material.dart';
import 'package:flutter_app/user_info.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseScreen extends StatefulWidget {
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen>
{
  Database currentDatabase;
  List<Map> users = [];

  @override
  void initState()
  {
    createDatabase();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('clicked');
          userDialog(context, null);
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: ListView.separated(
          itemBuilder: (ctx, index) => buildItem(ctx, users[index]),
          separatorBuilder: (ctx, index) => Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          itemCount: users.length,
      ),
    );
  }

  Widget buildItem(context, user) => Padding(
    padding: EdgeInsets.all(15.0),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 25.0,
          child: Text(
            '${user['id']}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => UserInfo(userInfo: user,)));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user['name']}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${user['phone']}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: (){
            userDialog(context, user);
          },
          icon: Icon(
            Icons.edit,
            color: Colors.green,
          ),
        ),
        IconButton(
          onPressed: (){
            deleteDialog(context, user['id']);
          },
          icon: Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
        ),
      ],
    ),
  );

  void createDatabase() async
  {
    await openDatabase(
        'contacts.db',
        version: 1,
        onOpen: (Database db) {
      currentDatabase = db;
      getUsers(false);
      print('database opened');
    }, onCreate: (Database db, int version) async {
      print('database created');
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, phone TEXT)');
    });
  }

  void insertUser(name, phone) async
  {
    if (currentDatabase != null)
    {
      currentDatabase.transaction((txn) async
      {
        int id = await txn.rawInsert(
            'INSERT INTO Users(name, phone) VALUES("$name", "$phone")').then((value)
        {
          getUsers(true);
          return null;
         });

        print('$id inserted');
      });
    }
  }

  void getUsers(from) async
  {
    users = await currentDatabase.rawQuery('SELECT * FROM Users');

    if(from)
    {
      setState(() {

      });
    }

    print(users.toString());
    print(users[0]['name']);
  }

  void updateUser(id, name, phone) async
  {
    int count = await currentDatabase.rawUpdate(
        'UPDATE Users SET name = ?, phone = ? WHERE id = $id',
        ['$name', '$phone']).then((value)
    {
      getUsers(true);
          return null;
        });
  }

  void deleteUser(id) async
  {
    await currentDatabase.rawDelete('DELETE FROM Users WHERE id = ?', ['$id']).then((value) {
      getUsers(true);
      return ;
    });
  }

  void userDialog(context, user)
  {
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    if(user != null)
    {
      nameController.text = user['name'];
      phoneController.text = user['phone'];
    }

    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'enter name..'
                    ),
                  ),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'enter phone..'
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    color: Colors.blue,
                    child: FlatButton(
                      onPressed: ()
                      {
                        if(user != null)
                          updateUser(user['id'],nameController.text, phoneController.text);
                        else
                          insertUser(nameController.text, phoneController.text);

                        Navigator.pop(context);
                      },
                      child: Text(
                        user == null ? 'add user'.toUpperCase() : 'update user'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  void deleteDialog(context, id)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are You Sure To Delete This Item?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                color: Colors.blue,
                child: FlatButton(
                  onPressed: ()
                  {
                    deleteUser(id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Yes'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}