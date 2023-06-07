import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// state
import '../../../state/global_variables.dart';

// components
import '../../../components/show_movie_details.dart';

Widget watchedMoviesGrid(BuildContext context) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 2 / 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
    ),
    itemCount: GlobalState.watchedMovies.length,
    itemBuilder: (context, index) {
      var movie = GlobalState.watchedMovies[index];
      return GestureDetector(
        onTap: () {
          showMovieDetails(context, movie);
        },
        child: movie['poster_path'] != null
            ? CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w185${movie['poster_path']}',
                fit: BoxFit.fill,
                placeholder: (context, url) => Stack(
                  alignment: Alignment.center,
                  children: const [
                    CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFF7D633),
                      ),
                    ),
                  ],
                ),
                errorWidget: (context, url, error) => Container(
                  width: 35,
                  height: 35,
                  color: Colors.white,
                ),
              )
            : Container(
                width: 35,
                height: 35,
                color: Colors.white,
              ),
      );
    },
  );
}
