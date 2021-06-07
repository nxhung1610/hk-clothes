import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/views/dashboard/account/account_page.dart';
import 'package:hk_clothes/views/dashboard/bag/bag_page.dart';
import 'package:hk_clothes/views/dashboard/home/home_page.dart';
import 'package:hk_clothes/views/dashboard/search/search_page.dart';

class DashboardController extends GetxController {
  static DashboardController instance = Get.find();

  RxInt selectItemBottom = 0.obs;

  final List<Widget> pageList = [
    HomePage(),
    SearchPage(),
    BagPage(),
    AccountPage(),
  ];

  void changeSelectItemBottom(int index) {
    selectItemBottom.value = index;
  }
}
