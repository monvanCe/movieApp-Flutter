// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// state
import '../state/global_variables.dart';

// utils
import '../utils/db_actions.dart';

class AddButton extends StatelessWidget {
  final dynamic movie;

  const AddButton({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, globalState, child) {
        bool isAdded =
            GlobalState.moviesToWatch.any((obj) => obj['id'] == movie['id']);

        void toggleIsAdded() {
          if (!isAdded) {
            dbMoviesToWatchAdd(context, movie);
            dbWatchedMoviesRemove(context, movie);
          } else {
            dbMoviesToWatchRemove(context, movie);
          }
        }

        return GestureDetector(
          onTap: toggleIsAdded,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: isAdded ? const Color(0xFFF7D633) : Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xFFF7D633),
                width: 1,
              ),
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
                  isAdded ? Icons.close : Icons.add,
                  key: ValueKey<bool>(isAdded),
                  color: isAdded ? Colors.black : const Color(0xFFF7D633),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
