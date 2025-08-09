
import 'package:get/get.dart';
import 'package:movie/models/actor.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/routes/app_routes.dart';
import 'package:movie/services/api_service.dart';

class ActorDetailsController extends GetxController {
  static const tagHeader = "actor_details_controller";

  final Rx<Actor?> actor = Rx<Actor?>(null);
  final RxList<Movie> movies = <Movie>[].obs;
  final RxBool isLoadingMovies = false.obs;

  @override
  void onInit() {
    super.onInit();
    final initialActor = Get.arguments as Actor;
    actor.value = initialActor;
    loadActorDetails(initialActor.id);
    loadActorMovies(initialActor.id);
  }

  Future<void> loadActorDetails(int actorId) async {
    try {
      final actorDetails = await ApiService.getActorDetails(actorId);
      actor.value = actorDetails;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load actor details: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
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
    Get.toNamed(AppRoutes.movieDetails, arguments: movie);
  }
}

class ActorDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final arguments = Get.arguments as Actor;
    Get.put<ActorDetailsController>(ActorDetailsController(), tag: "${ActorDetailsController.tagHeader}:${arguments.id}");
  }
}
