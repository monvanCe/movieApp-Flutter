import 'package:flutter/material.dart';
import 'package:movieapp/components/show_movie_details.dart';
import 'package:provider/provider.dart';

//components
import '../../../components/profile_list_item.dart';

//state
import '../../../state/global_variables.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, globalstate, _) {
        return Column(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Image.asset('assets/moviebanner.jpg'),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                              ],
                              stops: const [0, 0.5, 1],
                            ),
                          ),
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                  const Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Icon(Icons.person, color: Colors.grey, size: 128)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "${GlobalState.user['username']}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('İzleme Süresi'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: const [
                                Text('00'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('months')
                              ],
                            ),
                            Column(
                              children: const [
                                Text('00'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('days')
                              ],
                            ),
                            Column(
                              children: const [
                                Text('00'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('hours')
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('İzleme Sayısı'),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("${GlobalState.watchedMovies.length}")
                        ]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: const Text('İzleme Listesi'),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: GlobalState.moviesToWatch.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showMovieDetails(
                          context, GlobalState.moviesToWatch[index]);
                    },
                    child: Row(children: [
                      PListItem(movie: GlobalState.moviesToWatch[index]),
                      const SizedBox(
                        width: 10,
                      )
                    ]),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              alignment: Alignment.centerLeft,
              child: const Text('İzlenenler Listesi'),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: GlobalState.watchedMovies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showMovieDetails(
                          context, GlobalState.watchedMovies[index]);
                    },
                    child: Row(children: [
                      PListItem(movie: GlobalState.watchedMovies[index]),
                      const SizedBox(
                        width: 10,
                      )
                    ]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
