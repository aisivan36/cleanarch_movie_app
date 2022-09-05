import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie_detail.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_movie_detail.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_movie_watchlist_status.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/save_watchlist_movie.dart';
import 'package:flutter/cupertino.dart';

class MovieDetailNotifier extends ChangeNotifier {
  static const String watchlistAddSuccessMessage = 'Added to watchlist';

  static const String watchlistRemoveSuccessMessage = 'Removed from watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetMovieWatchlistStatus getWatchListStatus;
  final SaveWatchlistMovie saveWatchlist;
  final RemoveWatchlistMovie removeWatchlist;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.removeWatchlist,
    required this.saveWatchlist,
  });

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  RequestState _movieState = RequestState.empty;
  RequestState get movieState => _movieState;

  List<Movie> _recommendations = [];
  List<Movie> get recommendations => _recommendations;

  RequestState _recommendationsState = RequestState.empty;
  RequestState get recommendationsState => _recommendationsState;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.loading;
    notifyListeners();

    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);

    detailResult.fold((failure) {
      _movieState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (movie) {
      _recommendationsState = RequestState.loading;
      _movie = movie;
      notifyListeners();
      recommendationResult.fold((failure) {
        _recommendationsState = RequestState.error;
        _message = failure.message;
      }, (movies) {
        _recommendationsState = RequestState.loaded;
        _recommendations = movies;
      });
      _movieState = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> addToWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    /// TODO watch this,,, I removed "await" in case something went wrong head to fix it
    result.fold((failure) {
      _watchlistMessage = failure.message;
    }, (successMessage) {
      _watchlistMessage = successMessage;
    });
    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    /// TODO watch this,,, I removed "await" in case something went wrong head to fix it
    result.fold((failure) {
      _watchlistMessage = failure.message;
    }, (successMessage) {
      _watchlistMessage = successMessage;
    });

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);

    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
