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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
