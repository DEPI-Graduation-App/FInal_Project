import 'package:get/get.dart';
import 'package:news_depi_final_project/features/article_detail/controller/article_detail_controller.dart';

class ArticleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArticleDetailController());
  }
}
