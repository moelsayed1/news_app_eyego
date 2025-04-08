import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_eyego/Features/home/ui/views/widgets/news_list_view_builder.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          category,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 25.h, right: 16.w, left: 16.w),
        child: CustomScrollView(
          slivers: [
            NewsListViewBuilder(category: category),
          ],
        ),
      ),
    );
  }
}