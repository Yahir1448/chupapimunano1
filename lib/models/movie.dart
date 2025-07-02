import 'dart:convert';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final String posterPath;
  final String backdropPath;
  final List<int> genreIds;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.posterPath,
    required this.backdropPath,
    required this.genreIds,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
    };
  }
}
