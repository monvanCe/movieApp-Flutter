// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/global_variables.dart';

void movieToWatchAdd(BuildContext context, movie) {
  GlobalState.movieToWatch.add(movie);
  Provider.of<GlobalState>(context, listen: false).notifyListeners();
}

void movieToWatchRemove(BuildContext context, movie) {
  GlobalState.movieToWatch.removeWhere((obj) => obj['id'] == movie['id']);
  Provider.of<GlobalState>(context, listen: false).notifyListeners();
}
