import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String overview;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  const MovieModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((key) => key)),
        id: json['id'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        'backdrop_path': backdropPath,
        'genre_ids': List<dynamic>.from(genreIds.map((val) => val)),
        'id': id,
        'overview': overview,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'title': title,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };

  Movie toEntity() => Movie(
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        overview: overview,
        posterPath: posterPath,
        releaseDate: releaseDate,
        title: title,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        voteCount,
      ];
}
