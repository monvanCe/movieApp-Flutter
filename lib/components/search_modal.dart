// ignore_for_file: library_private_types_in_public_api, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';

import '../components/show_movie_details.dart';
import '../services/network.dart';

import '../utils/gstate_actions.dart';

class SearchModal extends StatefulWidget {
  const SearchModal({super.key});

  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  List<dynamic> searchedMovies = [];

  Future<void> _searchMovies(String query) async {
    final movies = await searchFunction(query);
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
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          movie['poster_path'] != null
                              ? showMovieDetails(context, movie)
                              : null;
                        },
                        contentPadding:
                            EdgeInsets.zero, // Remove the default padding
                        leading: SizedBox(
                            width: 80,
                            height: 120,
                            child: movie['poster_path'] != null
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w185${movie['poster_path']}',
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset(
                                    'assets/question.png',
                                    fit: BoxFit.contain,
                                  )),
                        title: Text(
                          movie['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Tarih: ${movie['release_date']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            movieToWatchAdd(context, movie);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: const Color(0xFFF7D633), // Border color
                                width: 1, // Border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(4), // Border radius
                            ),
                            child: const Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                  color: Color(0xFFF7D633),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
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
