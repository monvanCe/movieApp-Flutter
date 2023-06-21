//state
import '../../state/global_variables.dart';

//utils
import '../../utils/firebase_sync/fmovie_add.dart';

void fMoviesAdd(List<dynamic> lMovies) {
  for (var movie in lMovies) {
    fMovieAdd(GlobalState.user['UID'], movie['id'], movie['isWatched']);
  }
}
