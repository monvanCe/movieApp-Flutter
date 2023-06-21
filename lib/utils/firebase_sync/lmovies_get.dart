import '../../state/global_variables.dart';

List<Map<String, dynamic>> getLMovies() {
  List<Map<String, dynamic>> allMovies = [];

  allMovies.addAll(GlobalState.moviesToWatch
      .map((movie) => {'id': movie['id'], 'isWatched': false}));

  allMovies.addAll(GlobalState.watchedMovies
      .map((movie) => {'id': movie['id'], 'isWatched': true}));

  return allMovies;
}
