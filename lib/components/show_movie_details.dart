import 'package:flutter/material.dart';

void showMovieDetails(BuildContext context, movie) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  movie.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        );
      });
}