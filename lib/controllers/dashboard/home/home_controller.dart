import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/assets.dart';
import 'package:hk_clothes/models/category.dart';
import 'package:hk_clothes/views/dashboard/home/home_tab.dart';
import 'package:hk_clothes/views/dashboard/home/sale_tab.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  static HomeController instance = Get.find();

  // Tab place
  final listTabItem = [
    Tab(
      text: "Home",
    ),
    Tab(
      text: "Sale",
    ),
  ];
  final listTab = [
    HomeTab(),
    SaleTab(),
  ];
  TabController tabController;

  // Category
  final listCategory = [
    Category(name: "Shirt", icon: categoryShirt),
    Category(name: "T-Shirt", icon: categoryTShirt),
    Category(name: "Hoodies", icon: categoryHoodie),
    Category(name: "Short", icon: categoryShort),
    Category(name: "Pants", icon: categoryPants),
    Category(name: "Sweatshirt", icon: categorySweatshirt),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: listTabItem.length);
  }
}
