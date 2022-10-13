import 'package:cleanarch_movie_app/core/utils/failure.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:cleanarch_movie_app/movie/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class SearchMovies {
  final MovieRepository repository;

  const SearchMovies({required this.repository});

  Future<Either<Failure, List<Movie>>> execute({required String query}) {
    return repository.searchMovies(query);
  }
}
