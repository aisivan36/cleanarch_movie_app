import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter/foundation.dart';

class TopRatedMoviesNotifier extends ChangeNotifier {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesNotifier(this.getTopRatedMovies);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Movie> _movie = [];
  List<Movie> get movie => _movie;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.error;
      notifyListeners();
    }, (moviesData) {
      _movie = moviesData;
      _state = RequestState.loaded;
      notifyListeners();
    });
  }
}
