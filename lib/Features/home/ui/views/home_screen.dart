import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_eyego/Core/helpers/spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      body: Center(
        child: Text(
          'Welcome to the Home Page',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
