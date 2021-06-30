import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/controllers/auth/auth_controller.dart';
import 'package:hk_clothes/controllers/bag/bag_controller.dart';
import 'package:hk_clothes/controllers/contact/contact_controller.dart';
import 'package:hk_clothes/controllers/dashboard/home/home_controller.dart';
import 'package:hk_clothes/controllers/dashboard/search/search_controller.dart';
import 'package:hk_clothes/controllers/order/order_controller.dart';

import 'package:hk_clothes/controllers/product/product_controller.dart';

import 'package:hk_clothes/controllers/dashboard/shipping/shipping_controller.dart';
import 'package:hk_clothes/views/bag/bag_page.dart';
import 'package:hk_clothes/views/contact/contact_page.dart';
import 'package:hk_clothes/views/order/order_page.dart';

import 'package:hk_clothes/views/dashboard/account/editprofile/editprofile_page.dart';
import 'package:hk_clothes/views/dashboard/account/editprofile/updateinfo.dart';

import 'package:hk_clothes/views/dashboard/dashboard_page.dart';
import 'package:hk_clothes/views/dashboard/shipping/shipping_page.dart';
import 'package:hk_clothes/views/product/product_page.dart';
import 'package:hk_clothes/views/search/search_page.dart';
import 'package:hk_clothes/views/splash/splash.dart';

import 'controllers/dashboard/account/account_controller.dart';
import 'controllers/dashboard/account/updateinfo_controller.dart';
import 'controllers/dashboard/category/category_controller.dart';
import 'controllers/dashboard/dashboard_controller.dart';
import 'views/authentication/login_page.dart';
import 'views/authentication/register_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await initialization.then((value) {
    Get.put(BagController());
    Get.put(ProductController());
    Get.put(AuthController());
    Get.put(ContactController());
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(AccountController());
    Get.put(UpdateInfoController());
    Get.put(ShippingController());
    Get.put(CategoryController());
    Get.put(SearchController());
    Get.put(OrderController());
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
        fontFamily: "Quicksand",
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
          name: '/editprofile',
          page: () => EditProfilePage(),
        ),
        GetPage(
          name: '/updateinfo',
          page: () => UpdateInfo(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 350),
        ),
        GetPage(
          name: "/product",
          page: () => ProductPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 350),
        ),
        GetPage(
          name: "/bag",
          page: () => BagPage(),
          transition: Transition.topLevel,
          transitionDuration: Duration(milliseconds: 350),
        ),
        GetPage(
          name: "/search",
          page: () => SearchPage(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 350),
        ),
        GetPage(
          name: '/order',
          page: () => OrderInforPage(),
          transition: Transition.topLevel,
          transitionDuration: Duration(milliseconds: 350),
        ),
        GetPage(
          name: "/contact",
          page: () => ContactPage(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 350),
        ),
      ],
      initialRoute: "/splash",
    );
  }
}
