import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie/controllers/actor_details_controller.dart';
import 'package:movie/models/actor.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/widgets/movie_card.dart';

class ActorDetailsView extends GetView<ActorDetailsController> {
  final int actorId;

  const ActorDetailsView({super.key, required this.actorId});

  @override
  String? get tag {
    return "${ActorDetailsController.tagHeader}:$actorId";
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final actor = controller.actor.value;
        if (actor == null) {
          return const Center(
            child: Text(
              'Actor not found',
              style: TextStyle(color: AppTheme.textColor),
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            // App Bar with actor photo
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: AppTheme.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: 'actor_profile_${actor.id}',
                      child: CachedNetworkImage(
                        imageUrl: actor.fullProfileUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppTheme.surfaceColor,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppTheme.surfaceColor,
                          child: const Icon(
                            Icons.person,
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
                title: Text(
                  actor.name,
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Actor Details Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Actor Info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildActorInfo(actor),
                    ),
                    const SizedBox(height: 24),

                    // Biography
                    if (actor.biography != null && actor.biography!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: _buildBiography(actor),
                      ),

                    // Movies
                    _buildMoviesSection(),
                    SizedBox(height: padding.bottom),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildActorInfo(Actor actor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          actor.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),

        // Birthday
        if (actor.birthday != null && actor.birthday!.isNotEmpty)
          Row(
            children: [
              const Icon(Icons.cake, color: AppTheme.textSecondaryColor, size: 16),
              const SizedBox(width: 8),
              Text(
                'Born: ${actor.birthday}',
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),

        // Place of Birth
        if (actor.placeOfBirth != null && actor.placeOfBirth!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: AppTheme.textSecondaryColor, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    actor.placeOfBirth!,
                    style: const TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Known For Department
        if (actor.knownForDepartment != null && actor.knownForDepartment!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                const Icon(Icons.work, color: AppTheme.textSecondaryColor, size: 16),
                const SizedBox(width: 8),
                Text(
                  actor.knownForDepartment!,
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBiography(Actor actor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Biography',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          actor.biography!,
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.textColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMoviesSection() {
    return Obx(() {
      if (controller.isLoadingMovies.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final movies = controller.movies;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: const Text(
              'Movies',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (movies.isEmpty)
            const Text(
              'No movies found',
              style: TextStyle(color: AppTheme.textSecondaryColor),
            )
          else
            SizedBox(
              height: 280,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(
                    movie: movie,
                    onTap: () => controller.onMovieTap(movie),
                  );
                },
              ),
            ),
        ],
      );
    });
  }
}
