import 'package:flutter/foundation.dart';

class GlobalState extends ChangeNotifier {
  static List<dynamic> moviesToWatch = [];
  static List<dynamic> watchedMovies = [];
  static dynamic user = {
    'isLogging': false,
    'username': '',
    'mail': '',
  };
}
