import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//components
import './show_movie_details.dart';
import './add_button.dart';
import './watch_button.dart';

Widget searchModalList(BuildContext context, movie) {
  return Column(
    children: [
      ListTile(
        onTap: () {
          movie['poster_path'] != null
              ? showMovieDetails(context, movie)
              : null;
        },
        contentPadding: EdgeInsets.zero, // Remove the default padding
        leading: SizedBox(
            width: 80,
            height: 120,
            child: movie['poster_path'] != null
                ? CachedNetworkImage(
                    imageUrl:
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
          '${movie['original_title']}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.025,
              ),
              child: AddButton(movie: movie),
            ),
            Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.025,
              ),
              child: WatchButton(movie: movie),
            ),
          ],
        ),
      ),
      const Divider(),
    ],
  );
}
