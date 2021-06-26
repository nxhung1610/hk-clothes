import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController with  SingleGetTickerProviderMixin
{
  static SearchController instance = Get.find();

   RxBool isSearch =false.obs;

  Rx<FocusNode> myFocusNode =FocusNode().obs;


}


