import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter/cupertino.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieNotifier({required this.getWatchlistMovies});

  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();

    result.fold((failure) {
      _watchlistState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (moviesData) {
      _watchlistState = RequestState.loaded;
      _watchlistMovies = moviesData;
      notifyListeners();
    });
  }
}
