import 'package:get/get.dart';
import 'package:halo/halo.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/models/movie_details.dart';
import 'package:movie/services/api_service.dart';

class MovieDetailsController extends GetxController {
  final Rx<MovieDetails?> movieDetails = Rx<MovieDetails?>(null);
  final Rx<Movie?> initialMovie = Rx<Movie?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isLoadingCast = false.obs;

  @override
  void onInit() {
    super.onInit();
    final movie = Get.arguments as Movie;
    // Store initial movie data for immediate display

    // Load detailed movie information
    loadMovieDetails(movie);
  }

  Future<void> loadMovieDetails(Movie movie) async {
    movieDetails.value = null;
    initialMovie.value = movie;
    isLoading.value = true;
    try {
      final details = await ApiService.getMovieDetails(movie.id);
      movieDetails.value = details;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load movie details: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onActorTap(int actorId) async {
    final currentMovie = initialMovie.value;
    await Get.toNamed('/actor-details', arguments: actorId);
    if (currentMovie != null) {
      loadMovieDetails(currentMovie);
    }
  }
}

class MovieDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieDetailsController>(() => MovieDetailsController());
  }
}
