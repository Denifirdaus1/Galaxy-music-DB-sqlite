import 'package:galaxy_music/models/song.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SongDatabaseHelper {
  static final SongDatabaseHelper _instance = SongDatabaseHelper._internal();
  static Database? _database;

  factory SongDatabaseHelper() => _instance;
  SongDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'galaxy_music_songs.db');
    return await openDatabase(path, version: 1, onCreate: _createSongDatabase);
  }

  Future<void> _createSongDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE songs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        artistName TEXT,
        genre TEXT,
        filePath TEXT,
        coverPath TEXT,
        isLiked INTEGER
      )
    ''');
  }

  Future<int> addSong(Song song) async {
    final db = await database;
    return await db.insert('songs', song.toMap());
  }

  Future<List<Song>> searchSongsByTitle(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'songs', 
      where: 'title LIKE ?', 
      whereArgs: ['%$query%']
    );

    return List.generate(maps.length, (i) {
      return Song(
        id: maps[i]['id'],
        title: maps[i]['title'],
        artistName: maps[i]['artistName'],
        genre: maps[i]['genre'],
        filePath: maps[i]['filePath'],
        coverPath: maps[i]['coverPath'],
        isLiked: maps[i]['isLiked'] == 1
      );
    });
  }

  Future<void> toggleLikeSong(int songId, bool isLiked) async {
    final db = await database;
    await db.update(
      'songs', 
      {'isLiked': isLiked ? 1 : 0},
      where: 'id = ?',
      whereArgs: [songId]
    );
  }
}