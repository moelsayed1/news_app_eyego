import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app_eyego/Core/controllers/drawer_controller.dart';
import 'package:news_app_eyego/Core/helpers/spacing.dart';
import 'package:news_app_eyego/Core/widgets/custom_drawer.dart';
import 'package:news_app_eyego/Features/home/ui/views/widgets/categories_list_view.dart';
import 'package:news_app_eyego/Features/home/ui/views/widgets/news_list_view_builder.dart';
import 'package:news_app_eyego/Features/search/ui/search_screen.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final AppDrawerController drawerController = Get.put(AppDrawerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerController.scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: drawerController.openDrawer,
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SearchScreen());
            },
            icon: const Icon(Icons.search),
          ),
          horizontalSpace(10),
        ],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'News',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            horizontalSpace(5),
            Text(
              'Cloud',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          slivers: [
            SliverToBoxAdapter(
              child: CategoriesListView(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            NewsListViewBuilder(category: 'general'),
          ],
        ),
      ),
    );
  }
}
