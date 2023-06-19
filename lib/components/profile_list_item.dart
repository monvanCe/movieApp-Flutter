// ignore_for_file: library_private_types_in_public_api
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PListItem extends StatefulWidget {
  final dynamic movie;

  const PListItem({Key? key, required this.movie}) : super(key: key);

  @override
  _PListItemState createState() => _PListItemState();
}

class _PListItemState extends State<PListItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl:
                'https://image.tmdb.org/t/p/w185${widget.movie['poster_path']}',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
