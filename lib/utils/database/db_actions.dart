import 'package:flutter/material.dart';

//helper
import '../../helper/database_helper.dart';

//utils
import '../gstate_actions.dart';

void dbMoviesToWatchAdd(BuildContext context, movie) async {
  movieToWatchAdd(context, movie);
  await DatabaseHelper().insertWatchToMoviesById(movie);
}

void dbMoviesToWatchRemove(BuildContext context, movie) async {
  movieToWatchRemove(context, movie);
  await DatabaseHelper().removeWatchToMoviesById(movie['id']);
}

Future dbMoviesToWatchGet() async {
  final moviesToWatch = await DatabaseHelper().getMoviesToWatch();
  return moviesToWatch;
}

void dbWatchedMoviesAdd(BuildContext context, movie) async {
  watchedMoviesAdd(context, movie);
  await DatabaseHelper().insertWatchedMoviesById(movie);
}

void dbWatchedMoviesRemove(BuildContext context, movie) async {
  watchedMoviesRemove(context, movie);
  await DatabaseHelper().removeWatchedMoviesById(movie['id']);
}

Future dbWatchedMoviesGet() async {
  final watchedMovies = await DatabaseHelper().getWatchedMovies();
  return watchedMovies;
}

Future dbGetUser() async {
  final user = await DatabaseHelper().getUser();
  return user;
}
