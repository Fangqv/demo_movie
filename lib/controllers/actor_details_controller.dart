import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie/controllers/movie_details_controller.dart';
import 'package:movie/models/actor.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/services/api_service.dart';

class ActorDetailsController extends GetxController {
  static const tagHeader = "actor_details_controller";

  final Rx<Actor?> actor = Rx<Actor?>(null);
  final RxList<Movie> movies = <Movie>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMovies = false.obs;

  @override
  void onInit() {
    super.onInit();
    final actorId = Get.arguments as int;
    loadActorDetails(actorId);
    loadActorMovies(actorId);
  }

  Future<void> loadActorDetails(int actorId) async {
    isLoading.value = true;
    try {
      final actorDetails = await ApiService.getActorDetails(actorId);
      actor.value = actorDetails;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load actor details: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadActorMovies(int actorId) async {
    isLoadingMovies.value = true;
    try {
      final actorMovies = await ApiService.getActorMovies(actorId);
      movies.assignAll(actorMovies);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load actor movies: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingMovies.value = false;
    }
  }

  void onMovieTap(Movie movie) {
    Get.toNamed('/movie-details', arguments: movie);
  }
}

class ActorDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final arguments = Get.arguments as int;
    Get.put<ActorDetailsController>(ActorDetailsController(), tag: "${ActorDetailsController.tagHeader}:$arguments");
  }
}
