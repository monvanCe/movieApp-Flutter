import 'package:flutter/material.dart';
import '../../state/global_variables.dart';

class Films extends StatefulWidget {
  const Films({Key? key}) : super(key: key);

  @override
  State<Films> createState() => _FilmsState();
}

class _FilmsState extends State<Films> {
  @override
  Widget build(BuildContext context) {
    if (GlobalState.movieToWatch.isNotEmpty) {
      return Scaffold(
        body: SafeArea(
          child: ListView.builder(
            itemCount: GlobalState.movieToWatch.length,
            itemBuilder: (context, index) {
              final movie = GlobalState.movieToWatch[index];
              final title = movie['title'] as String?;
              return ListTile(
                title: Text(title ?? 'No title available'),
              );
            },
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('No movies to watch'),
          ),
        ),
      );
    }
  }
}
