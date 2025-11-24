// features/home/controller/home_controller.dart
import 'package:get/get.dart';
import 'package:news_depi_final_project/Services/NewsService.dart';
import '../Models/CategoryModel/category_model.dart';

class HomeController extends GetxController {
  final NewsService newsService = Get.find<NewsService>();
  var isLoading = true.obs;
  var categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() async {
    isLoading.value = false;
  }

  void onCategoryTap(CategoryModel category) {

  }
}


