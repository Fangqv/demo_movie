import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/home_controller.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/widgets/movie_card.dart';
import 'package:movie/widgets/loading_shimmer.dart';
import 'package:movie/gen/l10n.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          S.of(context).appTitle,
          style: const TextStyle(color: AppTheme.textColor),
        ),
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.textColor),
            onPressed: controller.onSearchTap,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.loadMovies,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trending Movies Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildSectionHeader(S.of(context).trendingMovies),
                  ),
                  const SizedBox(height: 12),
                  _buildMoviesList(
                    context,
                    controller.trendingMovies,
                    controller.isLoadingTrending,
                    Section.trending,
                  ),

                  const SizedBox(height: 32),

                  // Popular Movies Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildSectionHeader(S.of(context).popularMovies),
                  ),
                  const SizedBox(height: 12),
                  _buildMoviesList(
                    context,
                    controller.popularMovies,
                    controller.isLoadingPopular,
                    Section.popular,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppTheme.textColor,
      ),
    );
  }

  Widget _buildMoviesList(
    BuildContext context,
    RxList<Movie> movies,
    RxBool isLoading,
    Section section,
  ) {
    if (isLoading.value) {
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

    if (movies.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Text(
            S.of(context).noMoviesFound,
            style: const TextStyle(color: AppTheme.textSecondaryColor),
          ),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: MovieCard(
              movie: movie,
              section: section,
              onTap: () => controller.onMovieTap(movie, section),
            ),
          );
        },
      ),
    );
  }
}
