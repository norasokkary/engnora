import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:predicts_diabetes/JSON/users.dart';
import 'package:sqflite/sqflite.dart';

import '../JSON/reminder_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('diabetes_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, filePath);
    print('Database path: $path');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        usrId INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        email TEXT NOT NULL,
        usrPassword TEXT NOT NULL,
        bloodSugarLevel TEXT,
        profilePhotoPath TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        photoPath TEXT NOT NULL,
        hasDiabetes INTEGER NOT NULL,
        confidence REAL NOT NULL,
        analysisDate TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (usrId)
      )
    ''');

    await db.execute('''
    CREATE TABLE reminders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      medicineName TEXT NOT NULL,
      dose TEXT NOT NULL,
      repeat TEXT NOT NULL,
      selectedDateTime TEXT NOT NULL,
      isActive INTEGER NOT NULL
    )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('DROP TABLE IF EXISTS users');
      await db.execute('DROP TABLE IF EXISTS photos');
      await db.execute('DROP TABLE IF EXISTS reminders');
      await _createDB(db, newVersion);
    }
  }

  Future<bool> authenticate(Users usr) async {
    final db = await database;
    var result = await db.rawQuery(
        "SELECT * FROM users WHERE email = ? AND usrPassword = ?",
        [usr.email, usr.password]);
    return result.isNotEmpty;
  }

  Future<int> createUser(Users usr) async {
    final db = await database;
    return await db.insert("users", usr.toMap());
  }

  Future<int> createReminder(ReminderModel reminder) async {
    final db = await database;
    return await db.insert("reminders", reminder.toMap());
  }

  Future<ReminderModel?> getReminder(String medicineName) async {
    final db = await database;
    var res = await db.query("reminders",
        where: "medicineName = ?", whereArgs: [medicineName]);
    return res.isNotEmpty ? ReminderModel.fromMap(res.first) : null;
  }

  Future<ReminderModel?> getReminderByDate(String selectedDateTime) async {
    final db = await database;
    var res = await db.query(
      "reminders",
      where: "selectedDateTime = ?",
      whereArgs: [selectedDateTime],
    );
    return res.isNotEmpty ? ReminderModel.fromMap(res.first) : null;
  }

  Future<int> deleteReminder(String medicineName) async {
    final db = await database;
    return await db.delete(
      'reminders',
      where: 'medicineName = ?',
      whereArgs: [medicineName],
    );
  }

  Future<List<Map<String, dynamic>>> getAllReminders() async {
    final db = await database;
    return await db.query('reminders');
  }

  Future<Users?> getUser(String phoneNumber) async {
    final db = await database;
    var res = await db
        .query("users", where: "phoneNumber = ?", whereArgs: [phoneNumber]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  Future<Users?> getUserByEmail(String email) async {
    final db = await database;
    var res = await db.query("users", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  // ✅ تعديل: ترجع Users بدل Map
  Future<Users?> getUserById(int usrId) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'usrId = ?',
      whereArgs: [usrId],
    );
    return result.isNotEmpty ? Users.fromMap(result.first) : null;
  }

  // ✅ تعديل: تقبل Users بدل Map
  Future<int> updateUser(Users user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'usrId = ?',
      whereArgs: [user.usrId],
    );
  }

  Future<int> createPhoto(Map<String, dynamic> photoData) async {
    final db = await database;
    return await db.insert('photos', photoData);
  }

  Future<List<Map<String, dynamic>>> getUserPhotos(int userId) async {
    final db = await database;
    return await db.query('photos', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> queryTable(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<void> clearData() async {
    final db = await database;
    final photos = await db.query('photos');
    for (var photo in photos) {
      final path = photo['photoPath'] as String?;
      if (path != null) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
    }
    final users = await db.query('users');
    for (var user in users) {
      final path = user['profilePhotoPath'] as String?;
      if (path != null) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
    }
    await db.execute('DROP TABLE IF EXISTS photos');
    await db.execute('DROP TABLE IF EXISTS users');
    await db.execute('DROP TABLE IF EXISTS reminders');
    await _createDB(db, 2);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
