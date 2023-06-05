// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../components/add_button.dart';

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
