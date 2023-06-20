import 'package:flutter/foundation.dart';

class GlobalState extends ChangeNotifier {
  static List<dynamic> moviesToWatch = [];
  static List<dynamic> watchedMovies = [];
  static dynamic user = {
    'isLogged': false,
    'UID': '',
    'username': '',
    'mail': '',
  };
}
