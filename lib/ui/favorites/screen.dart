// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<Movie> _favoriteMovies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: _favoriteMovies.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = _favoriteMovies[index];
          return ListTile(
            title: Text(movie.title),
            trailing: const Icon(Icons.favorite),
          );
        },
      ),
    );
  }
}
