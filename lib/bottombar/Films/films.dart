import 'package:flutter/material.dart';

import '../../state/global_variables.dart';

import 'package:provider/provider.dart';

class Films extends StatelessWidget {
  const Films({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, globalState, _) {
        if (GlobalState.movieToWatch.isNotEmpty) {
          return Scaffold(
            body: SafeArea(
              child: ListView.builder(
                itemCount: GlobalState.movieToWatch.length,
                itemBuilder: (context, index) {
                  final movie = GlobalState.movieToWatch[index];
                  return ListTile(
                    title: Text(movie['title']),
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
      },
    );
  }
}
