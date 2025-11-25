import 'package:get/get.dart';
import '../Controllers/HomeController.dart';
import '../Services/NewsService.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize NewsService as a singleton
    Get.lazyPut<NewsService>(() => NewsService(), fenix: true);

    // Initialize HomeController
    Get.lazyPut<HomeController>(() => HomeController());
  }
}