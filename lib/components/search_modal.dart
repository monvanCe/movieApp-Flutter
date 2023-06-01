// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../services/network.dart';

class SearchModal extends StatefulWidget {
  const SearchModal({super.key});

  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  List<dynamic> searchedMovies = [];

  Future<void> _searchMovies(String query) async {
    final movies = await searchMovies(query);
    setState(() {
      searchedMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        _searchMovies(query);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                      cursorColor: const Color.fromRGBO(247, 214, 50, 255),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchedMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  final movie = searchedMovies[index];
                  return ListTile(
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w185${movie['poster_path']}',
                      width: 80,
                      height: 120,
                    ),
                    title: Text(movie['title']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
