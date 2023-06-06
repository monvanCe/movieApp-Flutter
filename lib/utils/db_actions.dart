import 'package:flutter/material.dart';

//helper
import '../helper/database_helper.dart';

//utils
import './gstate_actions.dart';

void dbAdd(BuildContext context, movie) async {
  movieToWatchAdd(context, movie);
  await DatabaseHelper().insertMovieId(movie['id']);
}

void dbRemove(BuildContext context, movie) async {
  movieToWatchRemove(context, movie);
  await DatabaseHelper().removeMovieById(movie['id']);
}

Future dbGet() async {
  final moviesToWatch = await DatabaseHelper().getMoviesToWatch();
  return moviesToWatch;
}
