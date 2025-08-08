import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie/controllers/actor_details_controller.dart';
import 'package:movie/models/actor.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/widgets/movie_card.dart';
import 'package:movie/gen/l10n.dart';

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
                    // Biography
                    if (actor.biography?.isNotEmpty == true) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _buildBiography(context, actor),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Personal Information
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildPersonalInfo(context, actor),
                    ),
                    const SizedBox(height: 24),

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
        if (actor.knownForDepartment?.isNotEmpty == true) _buildInfoRow(context, S.of(context).knownFor, actor.knownForDepartment!),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            S.of(context).noDataAvailable,
            style: const TextStyle(color: AppTheme.textSecondaryColor),
          ),
        ),
      ],
    );
  }
}
