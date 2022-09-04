import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarch_movie_app/core/styles/text_styles.dart';
import 'package:cleanarch_movie_app/core/utils/urls.dart';
import 'package:cleanarch_movie_app/movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Movie movie;

  const ItemCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    // TODO Wrap this container within GestureDetector navigate it into Movie Detail Screen
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: Urls.imageUrl(movie.posterPath!),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title ?? '-',
                  overflow: TextOverflow.ellipsis,
                  style: kHeading6,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        movie.releaseDate!.split('-').reversed.join('/'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18.0,
                    ),
                    const SizedBox(width: 4.0),
                    Text((movie.voteAverage! / 2).toStringAsFixed(1))
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  movie.overview ?? '-',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
