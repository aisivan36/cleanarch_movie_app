import 'package:cleanarch_movie_app/core/utils/failure.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie_detail.dart';
import 'package:cleanarch_movie_app/movie/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
