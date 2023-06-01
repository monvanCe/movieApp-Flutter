// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../const/api.dart';

Future<dynamic> fetchMovies(String query) async {
  String? url;

  switch (query) {
    case 'Vizyondakiler':
      url = nowPlayingApi;
      break;
    case 'Popüler':
      url = popularApi;
      break;
    case 'Beğenilenler':
      url = topRatedApi;
      break;
    case 'Yaklaşanlar':
      url = upComingApi;
      break;
  }

  if (url != null) {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  } else {
    throw Exception('URL is null');
  }
}

Future<List<dynamic>> searchFunction(String query) async {
  final url = '$searchApi&query=$query';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['results'] as List<dynamic>;
    } else {
      throw Exception(
          'Failed to search movies. Status code: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Failed to search movies: $error');
  }
}
