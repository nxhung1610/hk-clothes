import 'package:get/get.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_detail.dart';
import 'package:hk_clothes/models/product/product_sale.dart';
import 'package:hk_clothes/models/product/product_size.dart';
import 'package:hk_clothes/models/product/size.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxList<Size> sizes = <Size>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await firestore
        .collection("shopstore")
        .doc("products")
        .collection("size")
        .get()
        .then((value) => sizes.value =
            value.docs.map((e) => Size.fromJson(e.data())).toList());
    super.onReady();
  }

  void showInforItem(Product product, tag) {
    Get.toNamed("/product", arguments: [product, tag]);
  }

  Future<ProductDetail> getProductDetail(Product product) async {
    ProductDetail productDetail = ProductDetail();
    productDetail.item = product;
    var size = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_size")
        .where("pid", isEqualTo: product.pid)
        .get();
    productDetail.sizes =
        size.docs.map((e) => ProductSize.fromJson(e.data())).toList();

    var sale = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_size")
        .where("pid", isEqualTo: product.pid)
        .get();
    if (sale.docs.isNotEmpty) {
      productDetail.sale = ProductSale.fromJson(sale.docs[0].data());
    }
    return productDetail;
  }
}
