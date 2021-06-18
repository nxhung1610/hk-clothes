import 'package:get/get.dart';
import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_detail.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();

  void showInforItem(Product product) {
    Get.toNamed("/product", arguments: [product]);
  }
}