import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController with SingleGetTickerProviderMixin
{
  static CategoryController instance = Get.find();

  final controller = ScrollController();



  void scrollUp()
  {
    final double start =0;
    controller.animateTo(start, duration: Duration(milliseconds: 500), curve: Curves.easeIn);

  }

}