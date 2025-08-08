import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie/controllers/movie_details_controller.dart';
import 'package:movie/models/movie_details.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/widgets/actor_card.dart';

class MovieDetailsView extends GetView<MovieDetailsController> {
  const MovieDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final movieDetails = controller.movieDetails.value;
        if (movieDetails == null) {
          return const Center(
            child: Text(
              'Movie not found',
              style: TextStyle(color: AppTheme.textColor),
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
                    CachedNetworkImage(
                      imageUrl: movieDetails.backdropUrl,
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
                title: Text(
                  movieDetails.title,
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Movie Details Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie Info
                    _buildMovieInfo(movieDetails),
                    const SizedBox(height: 24),

                    // Overview
                    _buildOverview(movieDetails),
                    const SizedBox(height: 24),

                    // Cast
                    _buildCastSection(movieDetails),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMovieInfo(MovieDetails movie) {
    return Row(
      children: [
        // Poster
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 120,
            height: 180,
            child: CachedNetworkImage(
              imageUrl: movie.posterUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppTheme.surfaceColor,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppTheme.surfaceColor,
                child: const Icon(Icons.movie, color: AppTheme.textSecondaryColor),
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
                  if (movie.releaseYear.isNotEmpty && movie.runtime != null)
                    const Text(
                      ' • ',
                      style: TextStyle(color: AppTheme.textSecondaryColor),
                    ),
                  if (movie.runtime != null)
                    Text(
                      '${movie.runtime} min',
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
                  Text(
                    ' (${movie.voteCount} votes)',
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Genres
              if (movie.genres.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: movie.genres
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

  Widget _buildOverview(MovieDetails movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
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

  Widget _buildCastSection(MovieDetails movie) {
    final cast = movie.cast.take(10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cast',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 12),
        if (cast.isEmpty)
          const Text(
            'No cast information available',
            style: TextStyle(color: AppTheme.textSecondaryColor),
          )
        else
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (context, index) {
                final actor = cast[index];
                return ActorCard(
                  actor: actor,
                  onTap: () => controller.onActorTap(actor.id),
                );
              },
            ),
          ),
      ],
    );
  }
}
