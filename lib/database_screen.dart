import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseScreen extends StatefulWidget
{
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen>
{
  Database currentDatabase;

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
        title: Text(
          'Database'
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('clicked');
          getUsers();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void createDatabase() async
  {
    await openDatabase(
        'contacts.db',
        version: 1,
        onOpen: (Database db)
        {
          currentDatabase = db;
          print('database opened');
        },
        onCreate: (Database db, int version) async
        {
          print('database created');
          // When creating the db, create the table
          await db.execute('CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, phone TEXT)');
        });
  }

  void insertUser() async
  {
    if(currentDatabase != null)
    {
      currentDatabase.transaction((txn) async
      {
        int id = await txn.rawInsert('INSERT INTO Users(name, phone) VALUES("Abdullah Mansour", "1234")');
        print('$id inserted');
      });
    }
  }

  void getUsers() async
  {
    List<Map> list = await currentDatabase.rawQuery('SELECT * FROM Users');
    print(list.toString());
    print(list[0]['name']);
  }

  void updateUser() async
  {
    int count = await currentDatabase.rawUpdate(
        'UPDATE Users SET name = ?, phone = ? WHERE id = 1',
        ['Joe Ibrahim', '9876']
    );
  }

  void deleteUser() async
  {
    await currentDatabase
        .rawDelete('DELETE FROM Users WHERE id = ?', ['2']);
  }
}