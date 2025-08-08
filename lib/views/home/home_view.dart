import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/home_controller.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/theme/app_theme.dart';
import 'package:movie/widgets/movie_card.dart';
import 'package:movie/widgets/loading_shimmer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Movie App',
          style: TextStyle(color: AppTheme.textColor),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trending Movies Section
                  _buildSectionHeader('Trending Movies'),
                  const SizedBox(height: 12),
                  _buildMoviesList(controller.trendingMovies, controller.isLoadingTrending),

                  const SizedBox(height: 32),

                  // Popular Movies Section
                  _buildSectionHeader('Popular Movies'),
                  const SizedBox(height: 12),
                  _buildMoviesList(controller.popularMovies, controller.isLoadingPopular),
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

  Widget _buildMoviesList(RxList<Movie> movies, RxBool isLoading) {
    if (isLoading.value) {
      return SizedBox(
        height: 280,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) => const MovieCardShimmer(),
        ),
      );
    }

    if (movies.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'No movies found',
            style: TextStyle(color: AppTheme.textSecondaryColor),
          ),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: ListView.builder(
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
    );
  }
}
