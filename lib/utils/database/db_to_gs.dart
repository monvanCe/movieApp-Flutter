// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_typing_uninitialized_variables, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//state
import '../../state/global_variables.dart';

//utils
import '../../utils/database/db_actions.dart';
import '../../utils/gstate_actions.dart';

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
      movieToWatchAdd(context, movie);
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
      watchedMoviesAdd(context, movie);
    }
  }
}

void setUser(BuildContext context) async {
  final user = await dbGetUser();

  if (user != null) {
    GlobalState.user = {
      'isLogged': true,
      'UID': user['UID'],
      'username': user['username'],
      'mail': user['mail'],
    };
  }

  Provider.of<GlobalState>(context, listen: false).notifyListeners();
}
