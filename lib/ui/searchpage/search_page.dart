// ignore_for_file: constant_identifier_names, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movieapp/network/movie_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _movies = [];

  Future<void> _searchMovies(String query) async {
    final response = await http.get(Uri.parse('$searchApi&query=$query'));
    if (response.statusCode == 200) {
      setState(() {
        _movies = json.decode(response.body)['results'];
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
                color: Colors.white,
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.all(16.0),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  _searchMovies(query);
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: _movies[index]['poster_path'] != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w185${_movies[index]['poster_path']}',
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 35,
                            height: 35,
                            color: Colors.white,
                          ),
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
