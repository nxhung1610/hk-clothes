import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/views/dashboard/account/whistlist_tab.dart';

class AccountController extends GetxController with SingleGetTickerProviderMixin{
  static AccountController instance = Get.find();

  final listTabItem = [
    Tab(
      text: "WishList",
    ),

  ];
   final listTab = [
    WishListTab(),
    /*RecentViewTab(),*/
  ];

   TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: listTabItem.length);
  }
}