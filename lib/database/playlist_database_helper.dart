import 'package:galaxy_music/models/playlist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PlaylistDatabaseHelper {
  static final PlaylistDatabaseHelper _instance = PlaylistDatabaseHelper._internal();
  static Database? _database;

  factory PlaylistDatabaseHelper() => _instance;
  PlaylistDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async { // Perbaiki di sini
    String path = join(await getDatabasesPath(), 'galaxy_music_playlists.db');
    return await openDatabase(path, version: 1, onCreate: _createPlaylistDatabase);
  }

  Future<void> _createPlaylistDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE playlists(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        songIds TEXT
      )
    ''');
  }

  Future<int> createPlaylist(Playlist playlist) async {
    final db = await database;
    return await db.insert('playlists', playlist.toMap());
  }

  Future<List<Playlist>> getAllPlaylists() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('playlists');
    return List.generate(maps.length, (i) {
      return Playlist(
        id: maps[i]['id'],
        name: maps[i]['name'],
        songIds: maps[i]['songIds'].split(',').map(int.parse).toList()
      );
    });
  }

  Future<void> updatePlaylist(Playlist playlist) async {
    final db = await database;
    await db.update(
      'playlists',
      playlist.toMap(),
      where: 'id = ?',
      whereArgs: [playlist.id]
    );
  }

  Future<void> deletePlaylist(int id) async {
    final db = await database;
    await db.delete('playlists', where: 'id = ?', whereArgs: [id]);
  }
}