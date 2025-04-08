import 'package:flutter/material.dart';
import 'package:news_app_eyego/Features/home/data/models/artical_model.dart';
import 'package:news_app_eyego/Features/home/ui/views/widgets/news_tile.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({super.key, required this.articles});

  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 22.0),
          child: NewsTile(
            articleModel: articles[index],
          ),
        ),
        childCount: articles.length,
      ),
    );
  }
}