import 'package:cleanarch_movie_app/core/utils/failure.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie_detail.dart';
import 'package:cleanarch_movie_app/movie/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistMovie {
  final MovieRepository movieRepository;

  SaveWatchlistMovie({required this.movieRepository});

  Future<Either<Failure, String>> execute(MovieDetail movie) =>
      movieRepository.saveWatchlist(movie);
}
