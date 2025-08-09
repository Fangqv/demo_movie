import 'package:get/get.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/routes/app_routes.dart';
import 'package:movie/services/api_service.dart';

/// 主要解决在 Home 页面可能会出现两个相同的 Hero 标签，导致动画效果异常的问题
enum Section {
  trending,
  popular,
}

class HomeController extends GetxController {
  final RxList<Movie> trendingMovies = <Movie>[].obs;
  final RxList<Movie> popularMovies = <Movie>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingTrending = false.obs;
  final RxBool isLoadingPopular = false.obs;

  /// 用户是点击的那个 section 进入和更深一级的页面呢？
  final Rxn<Section> sectionTrack = Rxn<Section>();

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

  void onMovieTap(Movie movie, Section section) async {
    sectionTrack.value = section;
    await Get.toNamed(AppRoutes.movieDetails, arguments: movie);
    await Future.delayed(const Duration(milliseconds: 350));
    sectionTrack.value = null;
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
