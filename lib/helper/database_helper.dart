// ignore_for_file: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final pathToDatabase = join(dbPath, 'movies.db');

    return openDatabase(
      pathToDatabase,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE moviesToWatch (
          id INTEGER PRIMARY KEY,
          title STRING,
          original_title STRING,
          release_date STRING,
          overview STRING,
          poster_path STRING,
          vote_average STRING,
          vote_count INTEGER,
          backdrop_path STRING,
          genre_ids STRING
        )
      ''');

        db.execute('''
        CREATE TABLE watchedMovies (
          id INTEGER PRIMARY KEY,
          title STRING,
          original_title STRING,
          release_date STRING,
          overview STRING,
          poster_path STRING,
          vote_average STRING,
          vote_count INTEGER,
          backdrop_path STRING,
          genre_ids STRING
        )
      ''');
        db.execute('''
        CREATE TABLE user (
          id INTEGER PRIMARY KEY,
          isLogged BOOL,
          UID STRING,
          username STRING,
          mail STRING
        )
      ''');
      },
      version: 1,
    );
  }

  Future<void> resetTable(String tableName) async {
    final database = await initializeDatabase();

    await database.delete(tableName);
  }

  Future saveUser(user) async {
    final database = await initializeDatabase();

    return database.insert(
      'user',
      {
        'isLogged': 1,
        'UID': user['UID'],
        'username': user['username'],
        'mail': user['username']
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<Map<String, Object?>?> getUser() async {
    final database = await initializeDatabase();
    List user;

    user = await database.query('user');

    if (user.isNotEmpty) {
      return user.first;
    } else {
      return {'isLogged': 0, 'username': '', 'mail': ''};
    }
  }

  Future removeUser() async {
    final database = await initializeDatabase();

    await database.delete(
      'user',
      where: 'isLogged = ?',
      whereArgs: [1],
    );
  }

  Future insertWatchToMoviesById(movie) async {
    final database = await initializeDatabase();

    return database.insert(
      'moviesToWatch',
      {
        'id': movie['id'],
        'title': movie['title'],
        'original_title': movie['original_title'],
        'release_date': movie['release_date'],
        'overview': movie['overview'],
        'poster_path': movie['poster_path'],
        'vote_average': movie['vote_average'].toString(),
        'vote_count': movie['vote_count'],
        'backdrop_path': movie['backdrop_path'],
        'genre_ids': "${movie['genre_ids']}"
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future removeWatchToMoviesById(int movieId) async {
    final database = await initializeDatabase();

    return database.delete(
      'moviesToWatch',
      where: 'id = ?',
      whereArgs: [movieId],
    );
  }

  Future<List<Map<String, dynamic>>> getMoviesToWatch() async {
    final database = await initializeDatabase();

    return database.query('moviesToWatch');
  }

  Future<int> insertWatchedMoviesById(movie) async {
    final database = await initializeDatabase();

    return database.insert(
      'watchedMovies',
      {
        'id': movie['id'],
        'title': movie['title'],
        'original_title': movie['original_title'],
        'release_date': movie['release_date'],
        'overview': movie['overview'],
        'poster_path': movie['poster_path'],
        'vote_average': movie['vote_average'].toString(),
        'vote_count': movie['vote_count'],
        'backdrop_path': movie['backdrop_path'],
        'genre_ids': "${movie['genre_ids']}"
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> removeWatchedMoviesById(int movieId) async {
    final database = await initializeDatabase();

    return database.delete(
      'watchedMovies',
      where: 'id = ?',
      whereArgs: [movieId],
    );
  }

  Future<List<Map<String, dynamic>>> getWatchedMovies() async {
    final database = await initializeDatabase();

    return database.query('watchedMovies');
  }
}
