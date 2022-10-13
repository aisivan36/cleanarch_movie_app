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
import 'package:cleanarch_movie_app/seach/domain/usecases/search_movies.dart';
import 'package:cleanarch_movie_app/seach/domain/usecases/search_tvs.dart';
import 'package:cleanarch_movie_app/seach/presentation/bloc/search_bloc.dart';
import 'package:cleanarch_movie_app/tv/data/datasources/db/tv_database_helper.dart';
import 'package:cleanarch_movie_app/tv/data/datasources/tv_local_data_source.dart';
import 'package:cleanarch_movie_app/tv/data/datasources/tv_remote_data_source.dart';
import 'package:cleanarch_movie_app/tv/data/repositories/tv_repository_impl.dart';
import 'package:cleanarch_movie_app/tv/domain/repositories/tv_repository.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/get_on_the_air_tvs.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/get_popular_tvs.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/get_top_rated_tvs.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/get_tv_detail.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/get_tv_images.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/get_tv_recommendations.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/get_tv_season_episodes.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:cleanarch_movie_app/tv/domain/usecases/save_watchlist_tv.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/popular_tvs_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/tv_detail_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/tv_images_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/tv_list_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/tv_season_episodes_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/watchlist_tv_provider.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => TvSearchBloc(locator()));

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

  /// TVs Notifier
  locator.registerFactory(
    () => TvListNotifier(
      getOnTheAirTvs: locator(),
      getPopularTvs: locator(),
      getTopRatedTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeasonEpisodesNotifier(
      getTvSeasonEpisodes: locator(),
    ),
  );
  locator.registerFactory(
    () => TvImagesNotifier(
      getTvImages: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTvs: locator(),
    ),
  );

  /// Use Cases
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(repository: locator()));
  locator.registerLazySingleton(() => GetMovieImages(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  /// Use cases Tvs
  locator.registerLazySingleton(() => GetOnTheAirTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeasonEpisodes(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(repository: locator()));
  locator.registerLazySingleton(() => GetTvImages(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  locator.registerLazySingleton(
    () => GetMovieWatchlistStatus(
      repository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetTvWatchlistStatus(
      tvRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SaveWatchlistMovie(
      movieRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SaveWatchlistTv(
      tvRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveWatchlistMovie(
      movieRepository: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveWatchlistTv(
      tvRepository: locator(),
    ),
  );

  /// Repositories
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
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

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
    () => TvLocalDataSourceImpl(databaseHelper: locator()),
  );

  /// Helpers
  locator.registerLazySingleton<MovieDatabaseHelper>(
    () => MovieDatabaseHelper(),
  );
  locator.registerLazySingleton<TvDatabaseHelper>(
    () => TvDatabaseHelper(),
  );

  /// External
  locator.registerLazySingleton(
    () => http.Client(),
  );
}
