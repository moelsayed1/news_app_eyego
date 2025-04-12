import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app_eyego/Features/home/data/models/article_model.dart' show ArticleModel;

class NewsService {
  final Dio dio;

  NewsService(this.dio);

  Future<List<ArticleModel>> getTopHeadlines({required String category}) async {
    try {
      Response response = await dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=7d029235a3a54779ac27799eca66fa36&category=$category');

      Map<String, dynamic> jsonData = response.data;

      List<dynamic> articles = jsonData['articles'];

      List<ArticleModel> articlesList = [];

      for (var article in articles) {
        if (articles.indexOf(article) == 0) {
          print(article.toString());
          log("--------------------");
        }
        ArticleModel articleModel = ArticleModel.fromJson(article);
        articlesList.add(articleModel);
      }
      return articlesList;
    } catch (e) {
      return [];
    }
  }
}
