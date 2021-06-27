import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/bag/bag.dart';
import 'package:hk_clothes/models/bag/product_bag.dart';
import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_detail.dart';
import 'package:hk_clothes/models/product/product_sale.dart';
import 'package:hk_clothes/models/product/product_size.dart';
import 'package:hk_clothes/models/product/size.dart';
import 'package:hk_clothes/utils/helpers/show_loading.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxList<SizeProduct> sizes = <SizeProduct>[].obs;
  Rx<ScrollController> controller = ScrollController().obs;

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
            value.docs.map((e) => SizeProduct.fromJson(e.data())).toList());

    super.onReady();
  }

  void showInforItem(Product product, tag) {
    Get.toNamed("/product", arguments: [product, tag]);
  }

  Future<ProductDetail> getProductDetail(String pid) async {
    ProductDetail productDetail = ProductDetail();
    var product = Product.fromJson((await firestore
            .collection("shopstore")
            .doc("products")
            .collection("product_detail")
            .where("pid", isEqualTo: pid)
            .get())
        .docs
        .first
        .data());
    productDetail.item = product;
    var size = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_size")
        .where("pid", isEqualTo: pid)
        .get();
    productDetail.sizes =
        size.docs.map((e) => ProductSize.fromJson(e.data())).toList();
    productDetail.sizes.sort((a, b) => a.sid.compareTo(b.sid));
    var sale = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_size")
        .where("pid", isEqualTo: pid)
        .get();
    if (sale.docs.isNotEmpty) {
      productDetail.sale = ProductSale.fromJson(sale.docs[0].data());
    }
    return productDetail;
  }
}
