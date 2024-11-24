import 'package:galaxy_music/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class UserDatabaseHelper {
  static final UserDatabaseHelper _instance = UserDatabaseHelper._internal();
  static Database? _database;

  factory UserDatabaseHelper() => _instance;
  UserDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'galaxy_music_users.db');
    return await openDatabase(path, version: 1, onCreate: _createUserDatabase);
  }

  Future<void> _createUserDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT UNIQUE,
        password TEXT
      )
    ''');
  }

  // Fungsi untuk hashing password
  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  // Fungsi untuk register user
  Future<int> registerUser(User user) async {
    final db = await database;
    try {
      // Hash password sebelum menyimpan ke database
      user.password = hashPassword(user.password);
      return await db.insert('users', user.toMap());
    } catch (e) {
      if (e.toString().contains("UNIQUE constraint failed")) {
        throw Exception("Email already registered");
      }
      rethrow;
    }
  }

  // Fungsi untuk login user
  Future<User?> loginUser(String email, String password) async {
    final db = await database;
    // Hash password sebelum memeriksa
    String hashedPassword = hashPassword(password);
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hashedPassword],
    );

    return maps.isNotEmpty
        ? User(
            id: maps[0]['id'],
            name: maps[0]['name'],
            email: maps[0]['email'],
            password: maps[0]['password'],
          )
        : null;
  }
}
