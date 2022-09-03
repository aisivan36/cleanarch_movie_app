import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cleanarch_movie_app/core/utils/state_enum.dart';
import 'package:cleanarch_movie_app/core/utils/urls.dart';
import 'package:cleanarch_movie_app/movie/presentation/pages/popular_movies_page.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/movie_images_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/provider/movie_list_notifier.dart';
import 'package:cleanarch_movie_app/movie/presentation/widgets/minimal_detail.dart';
import 'package:cleanarch_movie_app/movie/presentation/widgets/sub_heading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainMoviePage extends StatefulWidget {
  const MainMoviePage({Key? key}) : super(key: key);

  @override
  State<MainMoviePage> createState() => _MainMoviePageState();
}

class _MainMoviePageState extends State<MainMoviePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () {
        Provider.of<MovieListNotifier>(context, listen: false)
            .fetchNowPlayingMovies()
            .whenComplete(
              () => Provider.of<MovieImagesNotifier>(context, listen: false)
                  .fetchMovieImages(
                Provider.of<MovieListNotifier>(context, listen: false)
                    .nowPlayingMovies[0]
                    .id,
              ),
            );

        /// Fetch Popular and TopRated Movies
        context.read<MovieListNotifier>().fetchPopularMovies();
        context.read<MovieListNotifier>().fetchTopRatedMovies();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        key: const Key('movieScrollView'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<MovieListNotifier>(
              builder: (context, value, child) {
                if (value.nowPlayingState == RequestState.loaded) {
                  return FadeIn(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 575.0,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) => context
                            .read<MovieImagesNotifier>()
                            .fetchMovieImages(
                              value.nowPlayingMovies[index].id,
                            ),
                      ),
                      items: [
                        ...value.nowPlayingMovies.map(
                          (item) => GestureDetector(
                            key: const Key('openMovieMinimalDetail'),
                            onTap: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                ),
                                context: context,
                                builder: (context) => MinimalDetail(
                                  movie: item,
                                  keyValue: 'goToMovieDetail',
                                  closeKeyValue: 'closeMovieMinimalDetail',
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) {
                                    return const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black,
                                        Colors.black,
                                        Colors.transparent,
                                      ],
                                      stops: [0, 0.3, 0.5, 1],
                                    ).createShader(
                                      Rect.fromLTRB(
                                        0,
                                        0,
                                        bounds.width,
                                        bounds.height,
                                      ),
                                    );
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: CachedNetworkImage(
                                    imageUrl: Urls.imageUrl(item.backdropPath!),
                                    height: 560.0,
                                    // width: 250,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.circle,
                                              color: Colors.red,
                                              size: 16.0,
                                            ),
                                            const SizedBox(width: 4.5),
                                            Text(
                                              'Now Playing'.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: Consumer<MovieImagesNotifier>(
                                          builder: (context, value, child) {
                                            if (value.movieImagesState ==
                                                RequestState.loaded) {
                                              if (value.movieImages.logoPaths
                                                  .isEmpty) {
                                                return Text(item.title!);
                                              }
                                              return CachedNetworkImage(
                                                width: 200.0,
                                                imageUrl: Urls.imageUrl(
                                                  value
                                                      .movieImages.logoPaths[0],
                                                ),
                                              );
                                            } else if (value.movieImagesState ==
                                                RequestState.error) {
                                              return const Center(
                                                child:
                                                    Text('Failed to load data'),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (value.nowPlayingState == RequestState.error) {
                  return const Center(
                    child: Text('Failed to load data'),
                  );
                } else {
                  return ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0, 0.3, 0.5, 1],
                      ).createShader(
                        Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        height: 575.0,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
              },
            ),
            SubHeading(
              text: 'Popular',
              valueKey: 'seePopularMovies',
              onSeeMoreTapped: () {
                if (kDebugMode) print('tapped');
                Navigator.pushNamed(context, PopularMoviesPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
