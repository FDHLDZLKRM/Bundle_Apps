import 'dart:io';

import 'user_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DbHelper {
  static Database? _db;

  static const String DB_Name = 'bundleApp3.db';
  static const String Table_User = 'pengguna';

  static const int Version = 1;
  static const int Version2 = 2;

  static const String C_UserName = 'user_name';
  static const String C_Password = 'password';
  static const String email = 'user_email';
  static const String phone = 'phone_num';

  //data that collect from booking


  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version2, onCreate: _onCreate);
    return db;
  }




  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $Table_User ("

        " $C_UserName TEXT, "
        " $email TEXT, "
        " $C_Password TEXT, "
        " $phone TEXT, "



        " PRIMARY KEY ($C_UserName)"
        ")");


    return db;

  }




  Future<int> saveData(UserDetail user) async {
    var dbClient = await db;
    var res = await dbClient!.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserDetail?> getLoginUser(String userName, String password) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserName = '$userName' AND "
        "$C_Password = '$password'");

    if (res.length>0) {
      return UserDetail.fromMap(res.first);
    }

    return null;
  }

  Future<int> updateUser(UserDetail user) async {
    var dbClient = await db;
    var res = await dbClient!.update(Table_User, user.toMap(),
        where: '$C_UserName = ?', whereArgs: [user.user_name]);
    return res;
  }

  Future<int> deleteUser(UserDetail user) async {
    var dbClient = await db;
    var res = await dbClient!.delete(Table_User, where: '$C_UserName = ?', whereArgs: [user.user_name]);
    return res;
  }



  //*********************************************************************************************************************************************






}
