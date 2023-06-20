import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//components
import '../childs/add_button.dart';
import '../childs/watch_button.dart';

void showMovieDetails(BuildContext context, movie) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.darken,
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w780${movie['backdrop_path']}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 32,
                      left: 16,
                      child: Text(
                        movie['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Text(
                        movie['original_title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                                size: 24,
                              ),
                              const SizedBox(width: 10),
                              Text(movie['release_date']),
                            ],
                          ),
                          Row(
                            children: [
                              AddButton(movie: movie),
                              const SizedBox(
                                width: 20,
                              ),
                              WatchButton(movie: movie),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      const Text(
                        'Film Açıklaması',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        movie['overview'],
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Color(0xFFF7D633),
                          ),
                          const SizedBox(width: 10),
                          Text("${movie['vote_count']}k kişi bu filmi izledi"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  "${movie['vote_average']}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
