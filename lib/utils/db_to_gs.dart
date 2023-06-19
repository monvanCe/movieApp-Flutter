// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';

//services
import 'package:movieapp/services/network.dart';

//utils
import 'package:movieapp/utils/db_actions.dart';
import 'package:movieapp/utils/gstate_actions.dart';

void movieToWatchGS(BuildContext context) async {
  var moviesToWatch;
  try {
    moviesToWatch = await dbMoviesToWatchGet();
  } catch (error) {
    print("sqflitedan izleme listesi alınamadı");
    moviesToWatch = [];
  }

  if (moviesToWatch.length > 0) {
    for (final movie in moviesToWatch) {
      final fetchedMovie = await fetchMovie(movie['movieId']);

      movieToWatchAdd(context, fetchedMovie);
    }
  }
}

void watchedMoviesGS(BuildContext context) async {
  var watchedMovies;
  try {
    watchedMovies = await dbWatchedMoviesGet();
  } catch (error) {
    print("sqflitedan izlenen listesi alınamadı");
    watchedMovies = [];
  }

  if (watchedMovies.length > 0) {
    for (final movie in watchedMovies) {
      final fetchedMovie = await fetchMovie(movie['movieId']);

      watchedMoviesAdd(context, fetchedMovie);
    }
  }
}
