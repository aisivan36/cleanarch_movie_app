import 'package:cleanarch_movie_app/core/utils/failure.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:cleanarch_movie_app/movie/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  const GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
