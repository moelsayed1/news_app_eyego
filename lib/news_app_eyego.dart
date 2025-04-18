import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_eyego/Features/home/ui/views/home_screen.dart';

class NewsAppEyego extends StatelessWidget {
  const NewsAppEyego({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App Eyego',
          home: const HomeScreen(),
        );
      },
    );
  }
}