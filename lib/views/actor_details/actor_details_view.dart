import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie/controllers/actor_details_controller.dart';
import 'package:movie/models/actor.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/gen/l10n.dart';
import 'package:movie/utils/hero_tag_utils.dart';
import 'package:movie/widgets/movie_card.dart';
import 'package:movie/widgets/loading_shimmer.dart';

class ActorDetailsView extends GetView<ActorDetailsController> {
  final Actor actor;

  const ActorDetailsView({super.key, required this.actor});

  @override
  String? get tag {
    return "${ActorDetailsController.tagHeader}:${actor.id}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Obx(() {
        final actor = controller.actor.value;
        if (actor == null) {
          return Center(
            child: Text(
              S.of(context).actorNotFound,
              style: const TextStyle(color: AppTheme.textColor),
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
                      tag: HeroTagUtils.generateActorProfileTag(context, actor.id),
                      child: FadeInImage(
                        placeholder: CachedNetworkImageProvider(actor.profileUrl),
                        image: CachedNetworkImageProvider(actor.fullProfileUrl),
                        fit: BoxFit.cover,
                        placeholderErrorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppTheme.surfaceColor,
                            child: const Icon(
                              Icons.person,
                              color: AppTheme.textSecondaryColor,
                              size: 100,
                            ),
                          );
                        },
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppTheme.surfaceColor,
                            child: const Icon(
                              Icons.person,
                              color: AppTheme.textSecondaryColor,
                              size: 100,
                            ),
                          );
                        },
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
                title: Hero(
                  tag: HeroTagUtils.generateActorNameTag(context, actor.id),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      actor.name,
                      style: const TextStyle(
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    // Personal Information
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildPersonalInfo(context, actor),
                    ),
                    const SizedBox(height: 24),

                    // Biography
                    if (actor.biography?.isNotEmpty == true) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _buildBiography(context, actor),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Known For Movies
                    _buildKnownForSection(context, actor),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildBiography(BuildContext context, Actor actor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).biography,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          actor.biography ?? S.of(context).noBiography,
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.textColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfo(BuildContext context, Actor actor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).personalInfo,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 12),
        if (actor.birthday?.isNotEmpty == true) _buildInfoRow(context, S.of(context).birthDate, actor.birthday!),
        if (actor.placeOfBirth?.isNotEmpty == true) _buildInfoRow(context, S.of(context).placeOfBirth, actor.placeOfBirth!),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKnownForSection(BuildContext context, Actor actor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            S.of(context).knownFor,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoadingMovies.value) {
            return SizedBox(
              height: 280,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => const MovieCardShimmer(),
              ),
            );
          }

          if (controller.movies.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                S.of(context).noDataAvailable,
                style: const TextStyle(color: AppTheme.textSecondaryColor),
              ),
            );
          }

          return SizedBox(
            height: 280,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: controller.movies.length,
              itemBuilder: (context, index) {
                final movie = controller.movies[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: MovieCard(
                    movie: movie,
                    onTap: () => controller.onMovieTap(movie),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
