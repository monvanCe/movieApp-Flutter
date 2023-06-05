import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// state
import '../../state/global_variables.dart';

// components
import '../../components/films_grid.dart';
import '../../components/films_empty.dart';

class Films extends StatelessWidget {
  const Films({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'İzleme Listesi',
          style: TextStyle(
            color: Color(0xFFF7D633),
          ),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: const Color(0xFFF7D633),
            height: 4.0,
          ),
        ),
      ),
      body: Consumer<GlobalState>(
        builder: (context, globalState, _) {
          if (GlobalState.movieToWatch.isNotEmpty) {
            return filmsGrid(context);
          } else {
            return filmsEmpty(context);
          }
        },
      ),
    );
  }
}
