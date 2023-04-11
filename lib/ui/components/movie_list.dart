// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movieapp/models/movie.dart';
import 'package:movieapp/network/movie_api.dart';
import 'package:movieapp/ui/components/show_movie_details.dart';

final Map<String, String> apiUrls = {
  'Vizyonda Olanlar': nowPlayingApi,
  'Popüler': popularApi,
  'En çok Beğenilenler': topRatedApi,
  'Yaklaşanlar': upComingApi,
};

Widget buildMoviesFutureBuilder({required String apiUrl}) {
  final String url = apiUrls[apiUrl]!;
  return FutureBuilder(
    future: fetchMovies(url),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final List<Movie> movies = snapshot.data!;
        return MoviesList(title: apiUrl, movies: movies);
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}

Future<List<Movie>> fetchMovies(String apiUrl) async {
  final response = await http.get(Uri.parse(apiUrl));
  final decodedData = json.decode(response.body);
  final MovieList movieList = MovieList.fromJson(decodedData);
  final List<Movie> movies = movieList.movies;
  return movies;
}

class MovieList {
  final List<Movie> movies;

  MovieList({required this.movies});

  factory MovieList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> results = json['results'];
    final List<Movie> movies =
        results.map((result) => Movie.fromJson(result)).toList();
    return MovieList(movies: movies);
  }
}

class MoviesList extends StatefulWidget {
  final String title;
  final List<Movie> movies;

  const MoviesList({Key? key, required this.title, required this.movies})
      : super(key: key);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  final _scrollController = ScrollController();
  bool _showLeftButton = false;
  bool _showRightButton = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showLeftButton = _scrollController.offset >= 256;
        _showRightButton = _scrollController.position.pixels <
            _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Stack(
            children: [
              ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (context, index) {
                  final movie = widget.movies[index];
                  return GestureDetector(
                    onTap: () => showMovieDetails(context, movie),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                iconSize: 20.0,
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
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
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: Visibility(
                  visible: _showLeftButton,
                  child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () => _scrollController.animateTo(
                        0,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 500),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: Visibility(
                    visible: _showRightButton,
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () => _scrollController.animateTo(
                          _scrollController.offset + 256,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 500),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
