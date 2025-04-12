import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_eyego/Features/home/ui/views/widgets/news_list_view_builder.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 22.h, right: 10.w, left: 10.w),
        child: CustomScrollView(
          slivers: [
            NewsListViewBuilder(category: category, articles: [],),
          ],
        ),
      ),
    );
  }
}