import 'package:flutter/material.dart';
import '../../state/global_variables.dart';
import 'package:provider/provider.dart';
import '../../components/show_movie_details.dart';
import '../../components/search_modal.dart';

class Films extends StatelessWidget {
  const Films({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, globalState, _) {
        if (GlobalState.movieToWatch.isNotEmpty) {
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
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: GlobalState.movieToWatch.length,
                  itemBuilder: (context, index) {
                    var movie = GlobalState.movieToWatch[index];
                    return GestureDetector(
                      onTap: () {
                        showMovieDetails(context, movie);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: movie['poster_path'] != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w185${movie['poster_path']}',
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 35,
                                height: 35,
                                color: Colors.white,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'İzleme Listesi',
                style: TextStyle(
                  color: Color(0xFFF7D633),
                ),
              ),
              backgroundColor: Colors.white,
              toolbarHeight: 42,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4.0),
                child: Container(
                  color: const Color(0xFFF7D633),
                  height: 3.0,
                ),
              ),
            ),
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'İzleme listen boş!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/empty-movie.png',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'İzlemek istediğin filmleri ekle.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return const SearchModal();
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF7D633),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Set the desired radius value
                          ),
                        ),
                        child: const Text(
                          'Film Ara',
                          style: TextStyle(
                            color: Colors.black, // Set the desired text color
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
