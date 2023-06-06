// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

//services
import 'package:movieapp/services/network.dart';

//utils
import 'package:movieapp/utils/db_actions.dart';
import 'package:movieapp/utils/gstate_actions.dart';

void dbToGs(BuildContext context) async {
  final moviesToWatch = await dbGet();

  if (moviesToWatch.length > 0) {
    for (final movie in moviesToWatch) {
      final fetchedMovie = await fetchMovie(movie['movieId']);

      movieToWatchAdd(context, fetchedMovie);
    }
  }
}
