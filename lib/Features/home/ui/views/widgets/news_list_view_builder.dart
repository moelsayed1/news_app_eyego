import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app_eyego/Core/networking/news_services.dart';
import 'package:news_app_eyego/Features/home/data/models/artical_model.dart';
import 'package:news_app_eyego/Features/home/ui/views/widgets/news_list_view.dart';


class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category, required List<ArticleModel> articles});

  final String category;

  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  late Future<List<ArticleModel>> future;

  @override
  void initState() {
    super.initState();
    future = NewsService(Dio()).getTopHeadlines(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NewsListView(articles: snapshot.data!);
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text('Oops there was an error, please try later'),
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
