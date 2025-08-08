import 'package:get/get.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/services/api_service.dart';

class HomeController extends GetxController {
  final RxList<Movie> trendingMovies = <Movie>[].obs;
  final RxList<Movie> popularMovies = <Movie>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingTrending = false.obs;
  final RxBool isLoadingPopular = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMovies();
  }

  Future<void> loadMovies() async {
    isLoading.value = true;

    try {
      await Future.wait([
        loadTrendingMovies(),
        loadPopularMovies(),
      ]);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load movies: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadTrendingMovies() async {
    isLoadingTrending.value = true;
    try {
      final movies = await ApiService.getTrendingMovies();
      trendingMovies.assignAll(movies);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load trending movies: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingTrending.value = false;
    }
  }

  Future<void> loadPopularMovies() async {
    isLoadingPopular.value = true;
    try {
      final movies = await ApiService.getPopularMovies();
      popularMovies.assignAll(movies);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load popular movies: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingPopular.value = false;
    }
  }

  void onMovieTap(Movie movie) {
    Get.toNamed('/movie-details', arguments: movie);
  }

  void onSearchTap() {
    Get.toNamed('/search');
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
