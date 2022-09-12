import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarch_movie_app/core/utils/urls.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:cleanarch_movie_app/movie/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';

class MinimalDetail extends StatelessWidget {
  final String? keyValue;
  final String? closeKeyValue;
  final Movie movie;

  const MinimalDetail({
    Key? key,
    required this.movie,
    this.closeKeyValue,
    this.keyValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 300.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    // flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: Urls.imageUrl(movie.posterPath!),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                movie.title ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: UnconstrainedBox(
                                child: SizedBox(
                                  height: 36.0,
                                  width: 36.0,
                                  child: TextButton(
                                    key: Key(closeKeyValue ?? '-'),
                                    onPressed: () => Navigator.pop(context),
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(1000.0),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                movie.releaseDate!
                                    .split('-')
                                    .reversed
                                    .join('/'),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              (movie.voteAverage! / 2).toStringAsFixed(1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          movie.overview ?? '-',
                          style: const TextStyle(fontSize: 12.0),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1.0,
              color: Colors.white70,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  key: Key(keyValue ?? '-'),
                  // TODO Watch this out, this is still buggy when tapped into when its back you will not back to the previous page
                  onPressed: () => Navigator.pushNamed(
                    context,
                    MovieDetailPage.routeName,
                    arguments: movie.id,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.info_outline, size: 16.0),
                          SizedBox(width: 8.0),
                          Text('Detail & More'),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
