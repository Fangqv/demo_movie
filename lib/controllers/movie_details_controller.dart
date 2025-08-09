import 'package:get/get.dart';
import 'package:movie/models/actor.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/models/movie_details.dart';
import 'package:movie/routes/app_routes.dart';
import 'package:movie/services/api_service.dart';

class MovieDetailsController extends GetxController {
  static const tagHeader = "movie_details_controller";

  final Rx<MovieDetails?> movieDetails = Rx<MovieDetails?>(null);
  final Rx<Movie?> initialMovie = Rx<Movie?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isLoadingCast = false.obs;

  @override
  void onInit() {
    super.onInit();
    final movie = Get.arguments as Movie;
    loadMovieDetails(movie);
  }

  Future<void> loadMovieDetails(Movie movie) async {
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

  void onActorTap(Actor actor) async {
    Get.toNamed(AppRoutes.actorDetails, arguments: actor);
  }
}

class MovieDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final movie = Get.arguments as Movie;
    Get.put<MovieDetailsController>(MovieDetailsController(), tag: "${MovieDetailsController.tagHeader}:${movie.id}");
  }
}
