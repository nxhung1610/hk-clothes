import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/controllers/auth/auth_controller.dart';
import 'package:hk_clothes/controllers/clothes/product_controller.dart';
import 'package:hk_clothes/controllers/dashboard/home/home_controller.dart';

import 'package:hk_clothes/views/dashboard/dashboard_page.dart';
import 'package:hk_clothes/views/product/product_page.dart';
import 'package:hk_clothes/views/splash/splash.dart';

import 'controllers/dashboard/dashboard_controller.dart';
import 'views/authentication/login_page.dart';
import 'views/authentication/register_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await initialization.then((value) {
    Get.put(AuthController());
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(ProductController());
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
        fontFamily: "UbuntuMono",
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
        GetPage(
          name: "/product",
          page: () => ProductPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 200),
        ),
      ],
      initialRoute: "/splash",
    );
  }
}
