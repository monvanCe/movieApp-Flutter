class Movie {
  int id;
  String title;
  String posterPath;
  String description;
  double rating;

  Movie(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.description,
      required this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        posterPath: json['poster_path'],
        description: json['overview'],
        rating: json['vote_average'].toDouble());
  }
}
