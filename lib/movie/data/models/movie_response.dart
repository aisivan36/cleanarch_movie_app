import 'package:cleanarch_movie_app/movie/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieRespone extends Equatable {
  final List<MovieModel> movieList;
  const MovieRespone({required this.movieList});

  factory MovieRespone.fromJson(Map<String, dynamic> json) => MovieRespone(
        movieList: List<MovieModel>.from(
          (json['results'] as List)
              .map((data) => MovieModel.fromJson(data))
              .where((element) =>
                  element.posterPath != null && element.backdropPath != null),
        ),
      );

  @override
  List<Object?> get props => [movieList];
}
