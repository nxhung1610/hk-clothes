import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/controllers/auth/auth_controller.dart';
import 'package:hk_clothes/controllers/home/dashboard_controller.dart';
import 'package:hk_clothes/views/splash/splash.dart';

import 'views/authentication/login_page.dart';
import 'views/authentication/register_page.dart';
import 'views/home/dashboard_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AuthController());
    Get.put(DashboardController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.app,
        primarySwatch: AppColors.app,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      getPages: [
        GetPage(
          name: "/home",
          page: () => DashboardPage(),
        ),
        GetPage(
          name: "/login",
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/register",
          page: () => RegisterPage(),
        ),
        GetPage(
          name: "/splash",
          page: () => SplashScreen(),
        ),
      ],
      initialRoute: "/splash",
    );
  }
}
