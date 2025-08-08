import 'package:get/get.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/services/api_service.dart';
import 'package:movie/views/movie_details/movie_details_view.dart';
import 'package:movie/controllers/movie_details_controller.dart';

class SearchController extends GetxController {
  final RxList<Movie> searchResults = <Movie>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  void onSearchChanged(String query) {
    searchQuery.value = query;
    if (query.length >= 3) {
      _debounceSearch(query);
    } else {
      searchResults.clear();
    }
  }

  Future<void> _debounceSearch(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (searchQuery.value == query) {
      await searchMovies(query);
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) return;

    isLoading.value = true;
    try {
      final results = await ApiService.searchMovies(query);
      searchResults.assignAll(results);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to search movies: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onMovieTap(Movie movie) {
    Get.to(
      () => MovieDetailsView(movie: movie),
      binding: MovieDetailsBinding(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
  }
}

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchController>(SearchController());
  }
}
