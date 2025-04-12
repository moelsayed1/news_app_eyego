import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_eyego/Core/controllers/drawer_controller.dart';
import 'package:news_app_eyego/Core/controllers/news_controller.dart';
import 'package:news_app_eyego/Features/home/data/models/category_model.dart';
import 'package:news_app_eyego/Features/home/ui/views/widgets/category_card.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  final List<CategoryModel> categories = const [
    CategoryModel(
      categoryImage: 'assets/images/business.avif',
      categoryName: 'Business',
    ),
    CategoryModel(
      categoryImage: 'assets/images/entertaiment.avif',
      categoryName: 'Entertainment',
    ),
    CategoryModel(
      categoryImage: 'assets/images/general.avif',
      categoryName: 'General',
    ),
    CategoryModel(
      categoryImage: 'assets/images/health.avif',
      categoryName: 'Health',
    ),
    CategoryModel(
      categoryImage: 'assets/images/science.avif',
      categoryName: 'Science',
    ),
    CategoryModel(
      categoryImage: 'assets/images/sports.avif',
      categoryName: 'Sports',
    ),
    CategoryModel(
      categoryImage: 'assets/images/technology.jpeg',
      categoryName: 'Technology',
    ),
  ];

  newsController controller = Get.put<newsController>(newsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
              children: List.generate(
            categories.length,
            (index) => GestureDetector(
              onTap: () {
                controller.onCategorySelected(categories[index].categoryName);
              },
              child: CategoryCard(
                category: categories[index],
              ).paddingAll(5),
            ),
          )),
        )
      ],
    );
  }
}
