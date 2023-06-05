// ignore_for_file: library_private_types_in_public_api, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';

//services
import '../services/network.dart';

//components
import './show_movie_details.dart';
import './add_button.dart';

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
                          child: MovieItem(movie: movie),
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

class MovieItem extends StatefulWidget {
  final dynamic movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://image.tmdb.org/t/p/w185${widget.movie['poster_path']}',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: AddButton(movie: widget.movie),
        ),
      ],
    );
  }
}
