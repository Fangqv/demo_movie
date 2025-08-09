import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/home_controller.dart';

class HeroTagUtils {
  static String generateMoviePosterTag(BuildContext context, int movieId, [Section? track]) {
    // 1. click movie card in "Trending"
    // 2. click movie card in "Popular"
    final homeController = Get.find<HomeController>();
    final finalTrack = track ?? homeController.sectionTrack.value;
    if (finalTrack == null) {
      // 3. click movie card in "Search"
      return 'movie_poster_$movieId';
    }
    return 'movie_poster_${movieId}_${finalTrack.name}';
  }

  static String generateMovieBackdropTag(BuildContext context, int movieId) {
    return 'movie_backdrop_$movieId';
  }

  static String generateActorProfileTag(BuildContext context, int actorId) {
    return 'actor_profile_$actorId';
  }

  static String generateActorNameTag(BuildContext context, int actorId) {
    return 'actor_name_$actorId';
  }
}
