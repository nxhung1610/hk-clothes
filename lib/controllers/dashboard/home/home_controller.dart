import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/views/dashboard/home/home_tab.dart';
import 'package:hk_clothes/views/dashboard/home/sale_tab.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  static HomeController instance = Get.find();
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

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: listTabItem.length);
  }
}
