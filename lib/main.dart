import 'package:cleanarch_movie_app/about_page.dart';
import 'package:cleanarch_movie_app/core/presentation/pages/home_page.dart';
import 'package:cleanarch_movie_app/core/presentation/pages/watchlist_page.dart';
import 'package:cleanarch_movie_app/core/presentation/provider/home_notifier.dart';
import 'package:cleanarch_movie_app/core/styles/colors.dart';
import 'package:cleanarch_movie_app/core/styles/text_styles.dart';
import 'package:cleanarch_movie_app/core/utils/utils.dart';
import 'package:cleanarch_movie_app/movie/presentation/pages/movie_detail_page.dart';
import 'package:cleanarch_movie_app/movie/presentation/pages/popular_movies_page.dart';
import 'package:cleanarch_movie_app/movie/presentation/pages/top_rated_movies_page.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/movie_detail_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/movie_list_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/movie_images_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/popular_movies_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:cleanarch_movie_app/seach/presentation/bloc/search_bloc.dart';
import 'package:cleanarch_movie_app/seach/presentation/pages/movie_search_page.dart';
import 'package:cleanarch_movie_app/seach/presentation/pages/tv_search_page.dart';
import 'package:cleanarch_movie_app/tv/presentation/pages/popular_tvs_page.dart';
import 'package:cleanarch_movie_app/tv/presentation/pages/top_rated_tvs_page.dart';
import 'package:cleanarch_movie_app/tv/presentation/pages/tv_detail_page.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/popular_tvs_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/top_rated_tvs_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/tv_detail_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/tv_images_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/tv_list_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/tv_season_episodes_notifier.dart';
import 'package:cleanarch_movie_app/tv/presentation/provider/watchlist_tv_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;

/// Certificate issue on Android
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

void main() {
  // HttpOverrides.global = MyHttpOverrides();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// General things
        ChangeNotifierProvider(
          create: (context) => di.locator<HomeNotifier>(),
        ),

        /// Movies Providers
        ChangeNotifierProvider(
          create: (context) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<MovieImagesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<MovieImagesNotifier>(),
        ),
        ChangeNotifierProvider<WatchlistMovieNotifier>(
          create: (context) => di.locator<WatchlistMovieNotifier>(),
        ),

        /// Tv notifier providers
        ChangeNotifierProvider(
          create: (context) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider<PopularTvsNotifier>(
          create: (context) => di.locator<PopularTvsNotifier>(),
        ),
        ChangeNotifierProvider<TopRatedTvsNotifier>(
          create: (context) => di.locator<TopRatedTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider<TvDetailNotifier>(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider<TvSeasonEpisodesNotifier>(
          create: (_) => di.locator<TvSeasonEpisodesNotifier>(),
        ),
        ChangeNotifierProvider<TvImagesNotifier>(
          create: (_) => di.locator<TvImagesNotifier>(),
        ),
        ChangeNotifierProvider<WatchlistTvNotifier>(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        BlocProvider<MovieSearchBloc>(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider<TvSearchBloc>(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Database App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(
            secondary: Colors.redAccent,
          ),
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (context) => const HomePage(),
              );
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(
                builder: (context) => const PopularMoviesPage(),
              );
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(
                builder: (context) => const TopRatedMoviesPage(),
              );

            case MovieDetailPage.routeName:
              return MaterialPageRoute(
                builder: (context) {
                  if (kDebugMode) print('Route ${settings.arguments}');

                  return MovieDetailPage(id: settings.arguments as int);
                },
                settings: settings,
              );

            case PopularTvsPage.routeName:
              return MaterialPageRoute(builder: (_) => const PopularTvsPage());
            case TopRatedTvsPage.routeName:
              return MaterialPageRoute(builder: (_) => const TopRatedTvsPage());
            case TvDetailPage.routeName:
              return MaterialPageRoute(
                builder: (_) {
                  if (kDebugMode) print('Route Tv main ${settings.arguments}');

                  return TvDetailPage(id: settings.arguments as int);
                },
                settings: settings,
              );
            case MovieSearchPage.routeName:
              return MaterialPageRoute(builder: (_) => const MovieSearchPage());
            case TvSearchPage.routeName:
              return MaterialPageRoute(builder: (_) => const TvSearchPage());

            case WatchlistPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());

            default:
              return MaterialPageRoute(
                builder: (context) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found'),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
