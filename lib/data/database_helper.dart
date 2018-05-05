import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtrack_timer/models/service_information.dart';
import 'package:youtrack_timer/models/authentication.dart';

class DatabaseHelper {
  // Singleton
  // static final DatabaseHelper _instance = new DatabaseHelper();
  // factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDatabase();
    return _db;
  }


  initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var dbInstance = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dbInstance;
  }

  void _onCreate(Database db, int version) async{
    await db.execute('CREATE TABLE ServiceInformation('
      + 'id INTEGER PRIMARY KEY,' 
      + 'serviceId TEXT,'
      + 'serviceUrl TEXT,'
      + 'serviceSecret TEXT,'
      + 'ringServiceId TEXT,'
      + 'serviceHubUrl TEXT)'
    );

    await db.execute('CREATE TABLE Authentication('
      + 'id INTEGER PRIMARY KEY,' 
      + 'tokenType TEXT,'
      + 'accessToken TEXT)'
    );

    print('Database Table created');
  }

  Future<int> saveServiceInformation(ServiceInformation serviceInformation) async {
    var dbClient = await db;
    var dbEntries = await dbClient.query("ServiceInformation");

    if (dbEntries.length > 0) {
      return await dbClient.update("ServiceInformation", serviceInformation.toMap());
    }
    return await dbClient.insert("ServiceInformation", serviceInformation.toMap());
    
  }

  Future<ServiceInformation> getServiceInformation() async {
    var dbClient = await db;
    var dbEntries = await dbClient.query("ServiceInformation");

    if (dbEntries.length == 0) {
      return null;
    }

    return new ServiceInformation.map(dbEntries.last);
  }

  Future<int> saveAuthentication (Authentication auth) async {
    var dbClient = await db;
    var dbEntries = await dbClient.query("Authentication");

    if (dbEntries.length > 0) {
      return await dbClient.update("Authentication", auth.toMap());
    }
    return await dbClient.insert("Authentication", auth.toMap());
  }

  Future<Authentication> getAuthentiction () async {
    var dbClient = await db;
    var dbEntries = await dbClient.query("Authentication");

    if (dbEntries.length == 0) {
      return null;
    }

    return new Authentication.map(dbEntries.last);
  }
}
