// ignore_for_file: unused_field
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';

class SaveUsersDb {
  static final SaveUsersDb instance = SaveUsersDb._init();

  static Database _database;

  SaveUsersDb._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('Users.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 6, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final boolType = 'BOOLEAN';
    final integerType = 'INTEGER';

    await db.execute(
        'CREATE TABLE $userTableName (id INTEGER PRIMARY KEY AUTOINCREMENT, userid INTEGER, email TEXT, username TEXT, role INTEGER)');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final boolType = 'BOOLEAN';
    final integerType = 'INTEGER';

    await db.execute(
        'CREATE TABLE $userTableName (id INTEGER PRIMARY KEY AUTOINCREMENT, userid INTEGER, email TEXT, username TEXT, role INTEGER)');
  }

  Future<User> create(User user) async {
    final db = await instance.database;

    await db.transaction((txn) async {
      var data = await txn.rawQuery("SELECT * FROM $userTableName");
      print("Length == " + data.toString());
      if (data.length <= 0) {
        int id1 = await txn.rawInsert(
            'INSERT INTO $userTableName (userId, email, username, role) VALUES( ${user.userId}, "${user.email}", "${user.username}", ${user.role} ) ');
        return user.copy(id: id1);
      }
    });

    return user.copy(id: -1);
  }

  Future<User> readUser() async {
    final db = await instance.database;

    final maps = await db.query(
      userTableName,
      columns: UserField.values,
    );
    if (maps.isNotEmpty) {
      print("RETURN FROM DB : " + maps.toString());
      return User.fromJson(maps.first);
    } else {
      print("RETURENED " + maps.toString());
    }
  }

  Future delete(int id) async {
    final db = await instance.database;

    var data = await db.rawQuery("TRUNCATE FROM $userTableName");

    print(data);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
