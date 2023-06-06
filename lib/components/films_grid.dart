import 'package:flutter/material.dart';

//state
import '../state/global_variables.dart';

//components
import '../components/show_movie_details.dart';

Widget filmsGrid(BuildContext context) {
  return SafeArea(
    child: Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: GlobalState.moviesToWatch.length,
        itemBuilder: (context, index) {
          var movie = GlobalState.moviesToWatch[index];
          return GestureDetector(
            onTap: () {
              showMovieDetails(context, movie);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: movie['poster_path'] != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w185${movie['poster_path']}',
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 35,
                      height: 35,
                      color: Colors.white,
                    ),
            ),
          );
        },
      ),
    ),
  );
}
