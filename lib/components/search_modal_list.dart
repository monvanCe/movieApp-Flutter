import 'package:flutter/material.dart';

//components
import './show_movie_details.dart';
import './add_button.dart';

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
                ? Image.network(
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
        trailing: Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: AddButton(movie: movie)),
      ),
      const Divider(),
    ],
  );
}
