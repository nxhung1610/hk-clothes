import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/views/home/account_page.dart';
import 'package:hk_clothes/views/home/bag_page.dart';
import 'package:hk_clothes/views/home/home_page.dart';
import 'package:hk_clothes/views/home/search_page.dart';

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
