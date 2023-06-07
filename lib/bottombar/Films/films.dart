// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// state
import '../../state/global_variables.dart';

// components
import 'components/movies_to_watch_grid.dart';
import 'components/movies_to_watch_empty.dart';
import 'components/watched_films_grid.dart';
import 'components/watched_films_empty.dart';

class Films extends StatefulWidget {
  const Films({Key? key}) : super(key: key);

  @override
  _FilmsState createState() => _FilmsState();
}

class _FilmsState extends State<Films> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentPageIndex = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'İzleme Listesi',
              style: TextStyle(color: Color(0xFFF7D633)),
            ),
            const Text(
              'İzlenen Filmler',
              style: TextStyle(color: Color(0xFFF7D633)),
            )
          ],
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: AnimatedAlign(
            alignment: _currentPageIndex == 0
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            duration: const Duration(milliseconds: 300),
            child: Container(
              color: const Color(0xFFF7D633),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 4.0,
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: const [
          FilmsToWatchScreen(),
          FilmsWatchedScreen(),
        ],
      ),
    );
  }
}

class FilmsToWatchScreen extends StatelessWidget {
  const FilmsToWatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, globalState, _) {
        if (GlobalState.moviesToWatch.isNotEmpty) {
          return moviesToWatchGrid(context);
        } else {
          return moviesToWatchEmpty(context);
        }
      },
    );
  }
}

class FilmsWatchedScreen extends StatelessWidget {
  const FilmsWatchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, globalState, _) {
        if (GlobalState.watchedMovies.isNotEmpty) {
          return watchedMoviesGrid(context);
        } else {
          return watchedMoviesEmpty(context);
        }
      },
    );
  }
}
