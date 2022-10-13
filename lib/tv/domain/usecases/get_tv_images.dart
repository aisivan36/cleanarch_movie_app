import 'package:cleanarch_movie_app/core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/media_image.dart';
import '../repositories/tv_repository.dart';

class GetTvImages {
  final TvRepository repository;

  GetTvImages(this.repository);

  Future<Either<Failure, MediaImage>> execute(int id) {
    return repository.getTvImages(id);
  }
}
