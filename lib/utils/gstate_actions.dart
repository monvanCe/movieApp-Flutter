// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//state
import '../state/global_variables.dart';

void movieToWatchAdd(BuildContext context, movie) {
  GlobalState.moviesToWatch.add(movie);
  Provider.of<GlobalState>(context, listen: false).notifyListeners();
}

void movieToWatchRemove(BuildContext context, movie) {
  GlobalState.moviesToWatch.removeWhere((obj) => obj['id'] == movie['id']);
  Provider.of<GlobalState>(context, listen: false).notifyListeners();
}
