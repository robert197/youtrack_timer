import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtrack_timer/models/service_information.dart';

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
      + 'serviceSecret TEXT,'
      + 'ringServiceId TEXT,'
      + 'serviceHubUrl TEXT)'
    );
    print('Database Table created');
  }

  Future<int> saveServiceInformation(ServiceInformation serviceInformation) async {
    var dbClient = await db;
    var dbEntries = await dbClient.query("ServiceInformation");

    if (dbEntries.length > 0) {
      return await dbClient.update("ServiceInformation", serviceInformation.toMap());
    } else {
      return await dbClient.insert("ServiceInformation", serviceInformation.toMap());
    }
  }

  Future<ServiceInformation> getServiceInformation() async {
    var dbClient = await db;
    var res = await dbClient.query("ServiceInformation");
    return new ServiceInformation.map(res.last);
  }
}
