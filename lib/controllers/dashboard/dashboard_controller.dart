import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/views/dashboard/account/account_page.dart';

import 'package:hk_clothes/views/dashboard/home/home_page.dart';
import 'package:hk_clothes/views/dashboard/shipping/shipping_page.dart';

class DashboardController extends GetxController {
  static DashboardController instance = Get.find();

  RxInt selectItemBottom = 0.obs;

  reloadData() {
    selectItemBottom.value = 0;
  }

  final List<Widget> pageList = [
    HomePage(),
    ShippingPage(),
    AccountPage(),
  ];

  void changeSelectItemBottom(int index) {
    selectItemBottom.value = index;
  }
}
