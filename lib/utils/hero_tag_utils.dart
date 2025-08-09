class HeroTagUtils {
  /// Generate a unique Hero tag for movie posters
  ///
  /// [movieId] - The movie ID
  /// [suffix] - Optional suffix to make the tag unique (e.g., section name + index)
  /// Returns a unique Hero tag string
  static String generateMoviePosterTag(int movieId, [String? suffix]) {
    if (suffix != null) {
      return 'movie_poster_${movieId}_$suffix';
    }
    return 'movie_poster_$movieId';
  }

  /// Generate a unique Hero tag for movie backdrops
  ///
  /// [movieId] - The movie ID
  /// Returns a unique Hero tag string
  static String generateMovieBackdropTag(int movieId) {
    return 'movie_backdrop_$movieId';
  }

  /// Generate a unique Hero tag for actor profiles
  ///
  /// [actorId] - The actor ID
  /// [suffix] - Optional suffix to make the tag unique
  /// Returns a unique Hero tag string
  static String generateActorProfileTag(int actorId, [String? suffix]) {
    if (suffix != null) {
      return 'actor_profile_${actorId}_$suffix';
    }
    return 'actor_profile_$actorId';
  }

  /// Generate a unique Hero tag for actor names
  ///
  /// [actorId] - The actor ID
  /// [suffix] - Optional suffix to make the tag unique
  /// Returns a unique Hero tag string
  static String generateActorNameTag(int actorId, [String? suffix]) {
    if (suffix != null) {
      return 'actor_name_${actorId}_$suffix';
    }
    return 'actor_name_$actorId';
  }
}
