import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GenreChart extends StatelessWidget {
  final List<Map<String, dynamic>> movies;

  const GenreChart({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final List<int> genreIds = [];

    for (final movie in movies) {
      if (movie['genre_ids'] is String) {
        if (movie['genre_ids'] != null) {
          String genreIdsString = movie['genre_ids'];

          genreIdsString =
              genreIdsString.replaceAll("[", "").replaceAll("]", "");
          List<String> genreIdsList = genreIdsString.split(",");
          try {
            genreIds.addAll(genreIdsList.map(int.parse).toList());
          } catch (e) {
            null;
          }
        } else if (movie['genre_ids'] is List) {
          if (movie['genre_ids'] != null) {
            genreIds.addAll(movie['genre_ids'].cast<int>());
          }
        }
      }
    }

    final Map<int, int> genreCounts = {};
    for (final genreId in genreIds) {
      genreCounts[genreId] = (genreCounts[genreId] ?? 0) + 1;
    }

    final sortedGenres = genreCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (sortedGenres.length > 5) {
      sortedGenres.removeRange(5, sortedGenres.length);
    }

    final data = [
      for (final entry in sortedGenres)
        GenreCount(entry.key, entry.value, getGenreName(entry.key)),
    ];

    final series = [
      charts.Series<GenreCount, String>(
        id: 'Genres',
        domainFn: (GenreCount count, _) =>
            count.genreName, // genreName kullanıldı
        measureFn: (GenreCount count, _) => count.count,
        data: data,
      ),
    ];

    final chart = charts.BarChart(
      series,
      animate: true,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: chart,
      ),
    );
  }
}

class GenreCount {
  final int genreId;
  final int count;
  final String genreName;

  GenreCount(this.genreId, this.count, this.genreName);
}

String getGenreName(int genreId) {
  if (genreId == 28) return 'Action';
  if (genreId == 12) return 'Macera';
  if (genreId == 16) return 'Animasyon';
  if (genreId == 35) return 'Komedi';
  if (genreId == 80) return 'Suç';
  if (genreId == 99) return 'Belgesel';
  if (genreId == 18) return 'Dram';
  if (genreId == 10751) return 'Aile';
  if (genreId == 14) return 'Fantastik';
  if (genreId == 36) return 'Tarih';
  if (genreId == 27) return 'Korku';
  if (genreId == 10402) return 'Müzik';
  if (genreId == 9648) return 'Gizem';
  if (genreId == 10749) return 'Romantik';
  if (genreId == 878) return 'Bilim-Kurgu';
  if (genreId == 10770) return 'TV film';
  if (genreId == 53) return 'Gerilim';
  if (genreId == 10752) return 'Savaş';
  if (genreId == 37) return 'Vahşi Batı';

  return 'Bilinmeyen Tür';
}
