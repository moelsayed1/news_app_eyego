import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_app_eyego/Core/controllers/auth_controllers.dart';
import 'package:news_app_eyego/Features/home/ui/views/home_screen.dart';
import 'Features/login/ui/login_screen.dart';

class NewsAppEyego extends StatefulWidget {
  const NewsAppEyego({super.key});

  @override
  State<NewsAppEyego> createState() => _NewsAppEyegoState();
}

class _NewsAppEyegoState extends State<NewsAppEyego> {
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child)  {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: BindingsBuilder(() {
            //Init webview service
            Get.lazyPut(() => AuthController());
          }),
          title: 'News App Eyego',
          home: FutureBuilder<Widget>(
            future: getUserPage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return LoginScreen();
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        );
      },
    );
  }

  Future<Widget> getUserPage() async {
    if ( await controller.checkIfLoggedInUser()) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}