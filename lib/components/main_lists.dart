// ignore_for_file: library_private_types_in_public_api, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../services/network.dart';
import './show_movie_details.dart';
import '../state/global_variables.dart';

class MainList extends StatefulWidget {
  final String category;

  const MainList({required Key key, required this.category}) : super(key: key);

  @override
  _MainListState createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMoviesData();
  }

  Future<void> fetchMoviesData() async {
    final moviesResponse = await fetchMovies(widget.category);
    setState(() {
      movies = moviesResponse['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 0, 8),
            child: Text(
              widget.category,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Stack(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return GestureDetector(
                        onTap: () => showMovieDetails(context, movie),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w185${movie['poster_path']}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    GlobalState.movieToWatch.add(movie);
                                    Provider.of<GlobalState>(context,
                                            listen: false)
                                        .notifyListeners();
                                  },
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: const Color(
                                            0xFFF7D633), // Border color
                                        width: 1, // Border width
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          4), // Border radius
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
