// ignore_for_file: library_private_types_in_public_api
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterLoginBackground extends StatefulWidget {
  const RegisterLoginBackground({super.key});

  @override
  _RegisterLoginBackground createState() => _RegisterLoginBackground();
}

class _RegisterLoginBackground extends State<RegisterLoginBackground> {
  List<String> movieImageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchTopRatedMovies();
  }

  Future<void> fetchTopRatedMovies() async {
    const upComingApi =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=4f098a761153500ca2a6a2d39980f694&language=tr-TR';

    final response = await http.get(Uri.parse('$upComingApi&page=1'));
    final jsonData = json.decode(response.body);
    final results = jsonData['results'];

    final response2 = await http.get(Uri.parse('$upComingApi&page=2'));
    final jsonData2 = json.decode(response2.body);
    final results2 = jsonData2['results'];

    if (mounted) {
      setState(() {
        movieImageUrls = [
          ...results.map<String>((movie) {
            final posterPath = movie['poster_path'];
            return 'https://image.tmdb.org/t/p/w154/$posterPath';
          }),
          ...results2.take(40 - results.length).map<String>((movie) {
            final posterPath = movie['poster_path'];
            return 'https://image.tmdb.org/t/p/w154/$posterPath';
          })
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: GridView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: movieImageUrls.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CachedNetworkImage(
                  imageUrl: movieImageUrls[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ],
      ),
    );
  }
}
