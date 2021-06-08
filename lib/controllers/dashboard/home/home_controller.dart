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
    Category(name: "Shirt", icon: category_shirt),
    Category(name: "T-Shirt", icon: category_t_shirt),
    Category(name: "Hoodies", icon: category_hoodie),
    Category(name: "Short", icon: category_short),
    Category(name: "Pants", icon: category_pants),
    Category(name: "Sweatshirt", icon: category_sweatshirt),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: listTabItem.length);
  }
}
