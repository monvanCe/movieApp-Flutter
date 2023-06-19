import 'package:flutter/foundation.dart';

class GlobalState extends ChangeNotifier {
  static List<dynamic> moviesToWatch = [];
  static List<dynamic> watchedMovies = [];
  static dynamic user = {
    'isLogged': true,
    'username': 'monvanCe',
    'mail': 'omerfkoca@gmail.com',
  };
}
