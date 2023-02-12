import 'package:get/get.dart';

import '../controllers/addArticles/add_articles_controller.dart';

class AddArticlesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddArticlesController>(
          () => AddArticlesController(),
    );
  }
}
