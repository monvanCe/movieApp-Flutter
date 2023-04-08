import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movie {
  final int id;
  final String title;
  final String posterPath;

  Movie({required this.id, required this.title, required this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
    );
  }
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
  final List<Movie> movies;

  MoviesList({required this.movies});

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
            'Now Playing',
            style: Theme.of(context).textTheme.headline6,
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                        fit: BoxFit.cover,
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
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () => _scrollController.animateTo(
                        0,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 500),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        shape: CircleBorder(),
                        padding: EdgeInsets.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      child: ElevatedButton(
                        onPressed: () => _scrollController.animateTo(
                          _scrollController.offset + 256,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 500),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          shape: CircleBorder(),
                          padding: EdgeInsets.zero,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  Future<List<Movie>> fetchMovies() async {
    final String apiKey = '4f098a761153500ca2a6a2d39980f694';
    final String url =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final decodedData = json.decode(response.body);
    final MovieList movieList = MovieList.fromJson(decodedData);
    final List<Movie> movies = movieList.movies;
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Last Movies'),
      ),
      body: FutureBuilder(
        future: fetchMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Movie> movies = snapshot.data!;
            return MoviesList(movies: movies);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
