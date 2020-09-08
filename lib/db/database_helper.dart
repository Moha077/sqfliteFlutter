import 'dart:io';


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbdd/model/user.dart';

class DatabaseHelper {
  static Database _db;
  final String userTable = "userTable";
  final String columnId = "id";
  final String columnUserName = "username";
  final String columnPassword = "password";
  final String columnCity = "city";
  final String columnAge = "age";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await intDB();
    return _db;
  }

  intDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'mydb.db');
    var myOwnDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myOwnDb;
  }

  void _onCreate(Database db, int newVersion) async {
    var sql = " CREATE TABLE $userTable ($columnId INTEGER PRIMARY KEY,"
        "$columnUserName TEXT, $columnPassword TEXT ,$columnCity TEXT ,$columnAge TEXT )";
    await db.execute(sql);
  }

  Future<int> saveUser(User user) async {
    var dbClinet = await db; 
    int result = await dbClinet.  insert('$userTable', user.toMap());
    return result;
  }
   Future<List> getAllUsers() async {
    var dbClinet = await db; 
    var sql ='SELECT *  FROM $userTable';
    List result = await dbClinet.rawQuery(sql);
    return result.toList();
  }

    Future<int> getCount() async {
    var dbClinet = await db; 
   var sql ='SELECT COUNT(*)  FROM $userTable';
    return Sqflite.firstIntValue(await  dbClinet.rawQuery(sql));
  }
      Future<User> getUser(int id) async {
    var dbClinet = await db; 
    var sql ='SELECT *  FROM $userTable WHERE $columnId= $id';
   var result = await dbClinet.rawQuery(sql);
   if(result.length>0){

    return new User.fromMap(result.first) ;}
    return null;
} 
    Future<int> deleteUser(int id) async {
    var dbClinet = await db; 
   return await dbClinet.delete(
     userTable,where:' $columnId= ?',whereArgs: [id]);
  }

     Future<int> updateUser(User user) async {
    var dbClinet = await db; 
   return await dbClinet.update(
     userTable,user.toMap(),where:' $columnId= ?',whereArgs: [user.id]
     );
  }
  
     Future  close() async {
    var dbClinet = await db; 
     return await dbClinet.close();
  } 
}