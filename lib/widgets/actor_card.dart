import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie/models/actor.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/utils/hero_tag_utils.dart';

class ActorCard extends StatelessWidget {
  final Actor actor;
  final VoidCallback? onTap;
  final String? heroTagSuffix;

  const ActorCard({
    super.key,
    required this.actor,
    this.onTap,
    this.heroTagSuffix,
  });

  @override
  Widget build(BuildContext context) {
    final heroTag = HeroTagUtils.generateActorProfileTag(actor.id, heroTagSuffix);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            // Actor Photo with Hero animation
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Hero(
                  tag: heroTag,
                  child: CachedNetworkImage(
                    imageUrl: actor.profileUrl,
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
                        Icons.person,
                        color: AppTheme.textSecondaryColor,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Actor Name
            Text(
              actor.name,
              style: const TextStyle(
                color: AppTheme.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
