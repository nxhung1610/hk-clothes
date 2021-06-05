import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/ViewModels/auth/login_controller.dart';
import 'package:hk_clothes/constant.dart';
import 'package:hk_clothes/views/pages/auth/login_page.dart';
import 'package:hk_clothes/views/pages/auth/register_page.dart';
import 'package:hk_clothes/views/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.app,
        primarySwatch: AppColors.app,
        canvasColor: Colors.transparent,
      ),
      getPages: [
        GetPage(
          name: "/main",
          page: () => HomePage(),
        ),
        GetPage(
          name: "/login",
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/register",
          page: () => RegisterPage(),
        ),
      ],
      initialRoute: "/login",
    );
  }
}
