import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie/controllers/home_controller.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/utils/hero_tag_utils.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;
  final Section? section;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.section,
  });

  @override
  Widget build(BuildContext context) {
    final heroTag = HeroTagUtils.generateMoviePosterTag(context, movie.id, section);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 145,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Movie Poster with Hero animation
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Hero(
                  tag: heroTag,
                  child: CachedNetworkImage(
                    imageUrl: movie.posterUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppTheme.surfaceColor,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppTheme.surfaceColor,
                      child: const Icon(
                        Icons.movie,
                        color: AppTheme.textSecondaryColor,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Movie Title with Hero animation
            SizedBox(
              height: 34, // Fixed height for title area
              child: Material(
                color: Colors.transparent,
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.2, // Adjust line height for better text display
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 4),

            // Release Year and Rating
            SizedBox(
              height: 16, // Fixed height for rating area
              child: Row(
                children: [
                  if (movie.releaseYear.isNotEmpty)
                    Expanded(
                      child: Text(
                        movie.releaseYear,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (movie.releaseYear.isNotEmpty && movie.voteAverage > 0)
                    const Text(
                      ' • ',
                      style: TextStyle(color: AppTheme.textSecondaryColor),
                    ),
                  if (movie.voteAverage > 0)
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                color: AppTheme.textSecondaryColor,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
