import 'dart:developer';

import 'package:get/get.dart';
import 'package:news_app_eyego/Features/home/data/models/artical_model.dart';
import 'package:dio/dio.dart' as ApiFetcher;

class newsController extends GetxController {
  List<ArticleModel> articles = [];
  List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];
  String selectedCategory = 'technology';
  bool isLoading = true;

  @override
  void onInit() {
    //Activate Dio
    getArticles();

    super.onInit();
  }

  onCategorySelected(String category) {
    isLoading = true;
    selectedCategory = category;
    articles.clear();
    getArticles();
    isLoading = false;
    update();
  }

  Future getArticles() async {
    isLoading = true;
    ApiFetcher.Response response = await ApiFetcher.Dio().get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=7d029235a3a54779ac27799eca66fa36&category=$selectedCategory');
    Map<String, dynamic> jsonData = response.data;
    List<dynamic> article2 = jsonData['articles'];

    for (var article in article2) {
      ArticleModel articleModel = ArticleModel.fromJson(article);
      articles.add(articleModel);
    }
    isLoading = false;
    update();
  }

  static Future<List<ArticleModel>> getArticlesBySearch(
      {required String query}) async {
    try {

      ApiFetcher.Response response = await ApiFetcher.Dio().get(
          'https://newsapi.org/v2/everything?q=$query&apiKey=7d029235a3a54779ac27799eca66fa36');
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articleData = jsonData['articles'];
      List<ArticleModel> articles = [];
      for (var article in articleData) {
        if (article['title'] == null) continue;
        ArticleModel articleModel = ArticleModel.fromJson(article);
        articles.add(articleModel);
        log("added an article ${articles.length}");
      }

      return articles;
    } on Exception {
      return [];
    }
  }
}
