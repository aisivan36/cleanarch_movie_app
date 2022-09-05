import 'package:cleanarch_movie_app/core/presentation/provider/home_notifier.dart';
import 'package:cleanarch_movie_app/movie/data/datasources/db/movie_database_helper.dart';
import 'package:cleanarch_movie_app/movie/data/datasources/movie_local_data_source.dart';
import 'package:cleanarch_movie_app/movie/data/datasources/movie_remote_data_source.dart';
import 'package:cleanarch_movie_app/movie/data/repository_impl/movie_repository_impl.dart';
import 'package:cleanarch_movie_app/movie/domain/repositories/movie_repository.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_moive_images.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_movie_detail.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_movie_watchlist_status.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_popular_movies.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/remove_watchlist_movie.dart';
import 'package:cleanarch_movie_app/movie/domain/usecases/save_watchlist_movie.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/movie_detail_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/movie_images_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/movie_list_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/popular_movies_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  /// TODO Movie Bloc Search and TV
  ///

  // Provider
  locator.registerFactory(() => HomeNotifier());

  locator.registerFactory(() => MovieListNotifier(
        getNowPlayingMovies: locator(),
        getPopularMovies: locator(),
        getTopRatedMovies: locator(),
      ));

  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieImagesNotifier(
      getMovieImages: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  /// Use Cases
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  // locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieImages(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(
    () => GetMovieWatchlistStatus(
      repository: locator(),
    ),
  );
  // locator.registerLazySingleton(
  //   () => GetTvWatchlistStatus(
  //     tvRepository: locator(),
  //   ),
  // );
  locator.registerLazySingleton(
    () => SaveWatchlistMovie(
      movieRepository: locator(),
    ),
  );
  // locator.registerLazySingleton(
  //   () => SaveWatchlistTv(
  //     tvRepository: locator(),
  //   ),
  // );
  locator.registerLazySingleton(
    () => RemoveWatchlistMovie(
      movieRepository: locator(),
    ),
  );
  // locator.registerLazySingleton(
  //   () => RemoveWatchlistTv(
  //     tvRepository: locator(),
  //   ),
  // );

  /// Repositories
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );

  /// Data Sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  /// Helpers
  locator.registerLazySingleton<MovieDatabaseHelper>(
    () => MovieDatabaseHelper(),
  );

  /// External
  locator.registerLazySingleton(
    () => http.Client(),
  );
}
