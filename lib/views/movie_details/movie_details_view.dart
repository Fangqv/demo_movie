import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie/controllers/movie_details_controller.dart';
import 'package:movie/models/movie_details.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/widgets/actor_card.dart';
import 'package:movie/gen/l10n.dart';
import 'package:movie/utils/hero_tag_utils.dart';

class MovieDetailsView extends GetView<MovieDetailsController> {
  final Movie movie;

  const MovieDetailsView({super.key, required this.movie});

  @override
  String? get tag {
    return "${MovieDetailsController.tagHeader}:${movie.id}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Obx(() {
        final movieDetails = controller.movieDetails.value;
        final initialMovie = controller.initialMovie.value;

        // Show loading only if we don't have initial data
        if (controller.isLoading.value && initialMovie == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Use initial movie data if detailed data is not available
        if (initialMovie == null) {
          return Center(
            child: Text(
              S.of(context).movieNotFound,
              style: const TextStyle(color: AppTheme.textColor),
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            // App Bar with backdrop
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: AppTheme.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: HeroTagUtils.generateMovieBackdropTag(initialMovie.id),
                      child: CachedNetworkImage(
                        imageUrl: movieDetails?.backdropUrl ?? initialMovie.posterUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppTheme.surfaceColor,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppTheme.surfaceColor,
                          child: const Icon(
                            Icons.movie,
                            color: AppTheme.textSecondaryColor,
                            size: 100,
                          ),
                        ),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppTheme.backgroundColor.withValues(alpha: 0.8),
                            AppTheme.backgroundColor,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                title: Material(
                  color: Colors.transparent,
                  child: Text(
                    initialMovie.title,
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Movie Details Content
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Info
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildMovieInfo(context, initialMovie, movieDetails),
                  ),
                  const SizedBox(height: 24),

                  // Overview
                  if (movieDetails != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildOverview(context, movieDetails),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Cast
                  if (movieDetails != null) _buildCastSection(context, movieDetails),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMovieInfo(BuildContext context, Movie movie, MovieDetails? movieDetails) {
    return Row(
      children: [
        // Poster with Hero animation
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 120,
            height: 180,
            child: Hero(
              tag: HeroTagUtils.generateMoviePosterTag(movie.id),
              child: FadeInImage(
                placeholder: CachedNetworkImageProvider(movie.posterUrl),
                image: CachedNetworkImageProvider(movie.posterUrl),
                fit: BoxFit.cover,
                placeholderErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.surfaceColor,
                    child: const Icon(Icons.movie, color: AppTheme.textSecondaryColor),
                  );
                },
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.surfaceColor,
                    child: const Icon(Icons.movie, color: AppTheme.textSecondaryColor),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Movie Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 8),

              // Release Year and Runtime
              Row(
                children: [
                  if (movie.releaseYear.isNotEmpty)
                    Text(
                      movie.releaseYear,
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 16,
                      ),
                    ),
                  if (movie.releaseYear.isNotEmpty && movieDetails?.runtime != null)
                    const Text(
                      ' • ',
                      style: TextStyle(color: AppTheme.textSecondaryColor),
                    ),
                  if (movieDetails?.runtime != null)
                    Text(
                      '${movieDetails!.runtime} ${S.of(context).minutes}',
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Rating
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (movieDetails?.voteCount != null)
                    Text(
                      ' (${movieDetails!.voteCount} ${S.of(context).voteCount})',
                      style: const TextStyle(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Genres
              if (movieDetails?.genres != null && movieDetails!.genres.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: movieDetails.genres
                      .map(
                        (genre) => Chip(
                          label: Text(genre.name),
                          backgroundColor: AppTheme.secondaryColor.withValues(alpha: 0.2),
                          labelStyle: const TextStyle(color: AppTheme.secondaryColor),
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverview(BuildContext context, MovieDetails movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).overview,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          movie.overview,
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.textColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCastSection(BuildContext context, MovieDetails movie) {
    final cast = movie.cast.take(10).toList();
    final controller = Get.find<MovieDetailsController>(tag: "movie_details_controller:${movie.id}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            S.of(context).cast,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (cast.isEmpty)
          Text(
            S.of(context).noDataAvailable,
            style: const TextStyle(color: AppTheme.textSecondaryColor),
          )
        else
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (context, index) {
                final actor = cast[index];
                return ActorCard(
                  actor: actor,
                  heroTagSuffix: 'cast_$index',
                  onTap: () => controller.onActorTap(actor),
                );
              },
            ),
          ),
      ],
    );
  }
}
