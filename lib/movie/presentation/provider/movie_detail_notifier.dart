import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
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
}
