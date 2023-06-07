// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

//services
import 'package:movieapp/services/network.dart';

//utils
import 'package:movieapp/utils/db_actions.dart';
import 'package:movieapp/utils/gstate_actions.dart';

void movieToWatchGS(BuildContext context) async {
  final moviesToWatch = await dbMoviesToWatchGet();

  if (moviesToWatch.length > 0) {
    for (final movie in moviesToWatch) {
      final fetchedMovie = await fetchMovie(movie['movieId']);

      movieToWatchAdd(context, fetchedMovie);
    }
  }
}

void watchedMoviesGS(BuildContext context) async {
  final watchedMovies = await dbMoviesToWatchGet();

  if (watchedMovies.length > 0) {
    for (final movie in watchedMovies) {
      final fetchedMovie = await fetchMovie(movie['movieId']);

      watchedMoviesAdd(context, fetchedMovie);
    }
  }
}
