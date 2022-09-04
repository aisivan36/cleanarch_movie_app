import 'package:cleanarch_movie_app/movie/domain/repositories/movie_repository.dart';

class GetMovieWatchlistStatus {
  final MovieRepository repository;

  GetMovieWatchlistStatus({required this.repository});

  Future<bool> execute(int id) async => repository.isAddedToWatchlist(id);
}
