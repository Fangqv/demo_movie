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
    initialMovie.value = movie;
    // Load detailed movie information
    loadMovieDetails(movie.id);

    // 监听路由变化
    ever(Get.routing.current.obs, (String? route) {
      _onRouteChanged(route);
    });
  }

  void _onRouteChanged(String? route) {
    qr;
    if (route == null) return;

    // 根据路由执行不同操作
    switch (route) {
      case '/home':
        // 返回首页时的处理
        break;
      case '/movie-details':
        // 进入电影详情页时的处理
        break;
      case '/actor-details':
        // 进入演员详情页时的处理
        break;
    }
  }

  @override
  void onClose() {
    // 清理监听器 - 移除这行，因为 String 没有 close 方法
    super.onClose();
  }

  Future<void> loadMovieDetails(int movieId) async {
    isLoading.value = true;
    try {
      final details = await ApiService.getMovieDetails(movieId);
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

  void onActorTap(int actorId) {
    Get.toNamed('/actor-details', arguments: actorId);
  }
}

class MovieDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieDetailsController>(() => MovieDetailsController());
  }
}
