Map<String, List<dynamic>> syncCompare(
    List<dynamic> fMovies, List<dynamic> lMovies) {
  List<dynamic> difference1 = [];
  List<dynamic> difference2 = [];

  for (dynamic fMovie in fMovies) {
    bool found = false;
    for (dynamic lMovie in lMovies) {
      if (fMovie['movieId'] == lMovie['id']) {
        found = true;
        break;
      }
    }
    if (!found) {
      difference1.add(fMovie);
    }
  }

  for (dynamic lMovie in lMovies) {
    bool found = false;
    for (dynamic fMovie in fMovies) {
      if (lMovie['id'] == fMovie['movieId']) {
        found = true;
        break;
      }
    }
    if (!found) {
      difference2.add(lMovie);
    }
  }

  return {
    'fMovies': difference1,
    'lMovies': difference2,
  };
}
