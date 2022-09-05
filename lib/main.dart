import 'dart:io';

import 'package:cleanarch_movie_app/core/presentation/pages/home_page.dart';
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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;

/// Certificate issue on Android
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
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
                builder: (context) =>
                    MovieDetailPage(id: settings.arguments as int),
                settings: settings,
              );

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
