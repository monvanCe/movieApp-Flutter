// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// state
import '../../state/global_variables.dart';

// utils
import '../../utils/database/db_actions.dart';

class WatchButton extends StatelessWidget {
  final dynamic movie;

  const WatchButton({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, globalState, child) {
        bool isWatched =
            GlobalState.watchedMovies.any((obj) => obj['id'] == movie['id']);

        void toggleIsWatched() {
          if (!isWatched) {
            dbWatchedMoviesAdd(context, movie);
            dbMoviesToWatchRemove(context, movie);
          } else {
            dbWatchedMoviesRemove(context, movie);
          }
        }

        return GestureDetector(
          onTap: toggleIsWatched,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: isWatched ? Colors.green : Colors.black12,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: Icon(
                  Icons.done,
                  key: ValueKey<bool>(isWatched),
                  color: isWatched ? Colors.white : Colors.black45,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
