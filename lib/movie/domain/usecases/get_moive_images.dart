import 'package:cleanarch_movie_app/core/utils/failure.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/media_image.dart';
import 'package:cleanarch_movie_app/movie/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetMovieImages {
  final MovieRepository repository;

  const GetMovieImages(this.repository);

  Future<Either<Failure, MediaImage>> execute(int id) {
    return repository.getMovieImages(id);
  }
}
