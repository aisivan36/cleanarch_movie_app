import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_popular_movies.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter/material.dart';

class MovieListNotifier extends ChangeNotifier {
  //
  var _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];
  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.empty;
  RequestState get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = 'null message';
  String get message => _message;

  MovieListNotifier({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  Future<void> fetchNowPlayingMovies() async {
    /// When it's loading
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        /// Check if it has an error
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();

        // print('Movie List Notifier: \n ${failure.message}');
      },
      (moviesData) {
        /// if all is set up ready to show the result
        _nowPlayingState = RequestState.loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();

        // print('Movie List Notifier: \n ${moviesData}');
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.error;
        _message = failure.message;
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
