import 'package:get/get.dart';
import 'package:news_depi_final_project/core/layouts/layout_controller.dart';
import 'package:news_depi_final_project/features/briefing/controller/briefing_controller.dart';
import 'package:news_depi_final_project/features/profile/controller/ProfileController.dart';
import '../../features/home/presentation/controller/HomeController.dart';
import '../../features/news/data/Services/NewsService.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Layout & Core
    Get.put(LayoutController());
    Get.lazyPut<NewsService>(() => NewsService(), fenix: true);

    // 2. Home
    Get.lazyPut<HomeController>(() => HomeController());

    // 3. Briefing Controller
    Get.lazyPut<AiBriefingController>(
      () => AiBriefingController(newsService: Get.find<NewsService>()),
    );

    // 4. Profile
    Get.lazyPut<Profilecontroller>(() => Profilecontroller());
  }
}
