import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/models/order/order.dart';
import 'package:hk_clothes/views/dashboard/shipping/bought_tab.dart';
import 'package:hk_clothes/views/dashboard/shipping/shipping_tab.dart';

class ShippingController extends GetxController
    with SingleGetTickerProviderMixin {
  static ShippingController instance = Get.find();

  final listTabItem = [
    Tab(
      text: "Shipping",
    ),
    Tab(
      text: "Bought",
    ),
  ];
  final listTab = [
    ShippingTab(),
    BoughtTab(),
  ];

  TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: listTabItem.length);
  }
}
