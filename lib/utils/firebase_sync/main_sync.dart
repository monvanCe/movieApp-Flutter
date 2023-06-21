import 'package:flutter/material.dart';

//state
import '../../state/global_variables.dart';

//utils
import '../../utils/database/db_actions.dart';
import '../../utils/firebase_sync/fmovies._add.dart';
import '../../utils/firebase_sync/lmovies_add.dart';
import '../../utils/firebase_sync/lmovies_get.dart';
import '../../utils/firebase_sync/sync_compare.dart';

import './fmovies_get.dart';

void mainSync(BuildContext context) async {
  final user = await dbGetUser();

  if (user['isLogged'] == 1) {
    final fMovies = await getFMoviesByUID(GlobalState.user['UID']);
    final lMovies = getLMovies();
    final compared = syncCompare(fMovies, lMovies);

    fMoviesAdd(compared['lMovies']!);
    // ignore: use_build_context_synchronously
    lMoviesAdd(compared['fMovies']!, context);
  }
}
