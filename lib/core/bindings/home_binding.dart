import 'package:get/get.dart';
import '../../features/home/presentation/controller/HomeController.dart';
import '../../features/news/data/Services/NewsService.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize NewsService as a singleton
    Get.lazyPut<NewsService>(() => NewsService(), fenix: true);

    // Initialize HomeController
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
