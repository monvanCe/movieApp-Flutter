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
          movieId INTEGER
        )
      ''');

        db.execute('''
        CREATE TABLE watchedMovies (
          id INTEGER PRIMARY KEY,
          movieId INTEGER
        )
      ''');
      },
      version: 1,
    );
  }

  Future<int> insertWatchToMoviesById(int movieId) async {
    final database = await initializeDatabase();

    return database.insert(
      'moviesToWatch',
      {'movieId': movieId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> removeWatchToMoviesById(int movieId) async {
    final database = await initializeDatabase();

    return database.delete(
      'moviesToWatch',
      where: 'MovieId = ?',
      whereArgs: [movieId],
    );
  }

  Future<List<Map<String, dynamic>>> getMoviesToWatch() async {
    final database = await initializeDatabase();

    return database.query('moviesToWatch');
  }

  Future<int> insertWatchedMoviesById(int movieId) async {
    final database = await initializeDatabase();

    return database.insert(
      'watchedMovies',
      {'movieId': movieId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> removeWatchedMoviesById(int movieId) async {
    final database = await initializeDatabase();

    return database.delete(
      'watchedMovies',
      where: 'MovieId = ?',
      whereArgs: [movieId],
    );
  }

  Future<List<Map<String, dynamic>>> getWatchedMovies() async {
    final database = await initializeDatabase();

    return database.query('watchedMovies');
  }
}
