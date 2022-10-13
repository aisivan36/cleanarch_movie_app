import 'package:cleanarch_movie_app/core/utils/failure.dart';
import 'package:cleanarch_movie_app/tv/domain/entities/tv.dart';
import 'package:cleanarch_movie_app/tv/domain/repositories/tv_repository.dart';
import 'package:dartz/dartz.dart';

class SearchTvs {
  final TvRepository repository;

  const SearchTvs({required this.repository});

  Future<Either<Failure, List<Tv>>> execute({required String query}) =>
      repository.searchTvs(query);
}
