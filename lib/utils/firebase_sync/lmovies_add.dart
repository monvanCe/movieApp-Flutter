import 'package:flutter/material.dart';

//services
import '../../services/network.dart';
import '../../utils/database/db_actions.dart';

void lMoviesAdd(List<dynamic> fMovies, BuildContext context) async {
  for (var movie in fMovies) {
    if (movie['isWatched'] == true) {
      final fetchedMovie = await fetchMovieById(movie['movieId']);
      // ignore: use_build_context_synchronously
      dbWatchedMoviesAdd(context, fetchedMovie);
    } else {
      final fetchedMovie = await fetchMovieById(movie['movieId']);
      // ignore: use_build_context_synchronously
      dbMoviesToWatchAdd(context, fetchedMovie);
    }
  }
}
