import 'package:get/get.dart';
import 'package:news_app_eyego/Features/home/data/models/artical_model.dart';

import 'news_controller.dart';

enum ArticlesSearchStates { initial, loading, success, failure, empty }

class ArticlesSearchController extends GetxController {
  var state = ArticlesSearchStates.initial.obs;
  var errorMessage = ''.obs;
  List<ArticleModel> articles = <ArticleModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchSearchArticles({required String query}) async {
    isLoading.value = true;
    state.value = ArticlesSearchStates.loading;

    final results = await newsController.getArticlesBySearch(query: query);

    if (results.isEmpty) {
      state.value = ArticlesSearchStates.empty;
    } else {
      articles.assignAll(results);
      state.value = ArticlesSearchStates.success;
    }

    isLoading.value = false;
  }
}
