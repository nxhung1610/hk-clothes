import 'package:get/get.dart';
import 'package:hk_clothes/models/product/product_detail.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();

  ProductDetail product;

  void showInforItem(ProductDetail productDetail) {
    this.product = productDetail;
    Get.toNamed("/product");
  }
}
