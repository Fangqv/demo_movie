import 'package:get/get.dart';
import 'package:movie/routes/app_routes.dart';
import 'package:movie/views/splash/splash_view.dart';
import 'package:movie/views/home/home_view.dart';
import 'package:movie/views/movie_details/movie_details_view.dart';
import 'package:movie/views/actor_details/actor_details_view.dart';
import 'package:movie/views/search/search_view.dart';
import 'package:movie/controllers/splash_controller.dart';
import 'package:movie/controllers/home_controller.dart';
import 'package:movie/controllers/movie_details_controller.dart';
import 'package:movie/controllers/actor_details_controller.dart';
import 'package:movie/controllers/search_controller.dart';
import 'package:movie/models/movie.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.movieDetails,
      page: () {
        final movie = Get.arguments as Movie;
        return MovieDetailsView(movie: movie);
      },
      binding: MovieDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.actorDetails,
      page: () {
        final actorId = Get.arguments as int;
        return ActorDetailsView(actorId: actorId);
      },
      binding: ActorDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
  ];
}
