import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_eyego/news_app_eyego.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(NewsAppEyego());
}


