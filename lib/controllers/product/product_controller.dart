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
  RxList<SizeProduct> sizes;
  Rx<ScrollController> controller;
  RxList<String> whitelist;

  @override
  void onInit() {
    super.onInit();
    sizes = <SizeProduct>[].obs;
    controller = ScrollController().obs;
    whitelist = <String>[].obs;
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
    var sale = await getSaleProduct(pid);
    if (sale != null) {
      productDetail.sale = sale;
    }
    return productDetail;
  }

  Future getSaleProduct(String pid) async {
    var sale = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_sale")
        .where("pid", isEqualTo: pid)
        .get();
    if (sale.docChanges.isNotEmpty) {
      return ProductSale.fromJson(sale.docs[0].data());
    } else
      return null;
  }

  Future<bool> likeProduct(String pid, bool isLiked) async {
    if (!isLiked)
      try {
        await firestore
            .collection("users")
            .doc(authController.userInfor.value.uid)
            .collection('status')
            .doc('whitelist')
            .update({
          'products': FieldValue.arrayUnion([pid])
        });
      } catch (e) {
        return isLiked;
      }
    else
      try {
        await firestore
            .collection("users")
            .doc(authController.userInfor.value.uid)
            .collection('status')
            .doc('whitelist')
            .update({
          'products': FieldValue.arrayRemove([pid])
        });
      } catch (e) {
        return isLiked;
      }
    return !isLiked;
  }

  void fetchWhiteList() {
    try {
      firestore
          .collection("users")
          .doc(authController.userInfor.value.uid)
          .collection('status')
          .doc('whitelist')
          .snapshots()
          .listen((event) {
        whitelist.clear();
        if (event.exists) {
          whitelist.addAll(
              (event.data()['products'] as List<dynamic>).cast<String>());
        } else
          firestore
              .collection("users")
              .doc(authController.userInfor.value.uid)
              .collection('status')
              .doc('whitelist')
              .set({'products': []});
      });
    } catch (e) {
      whitelist.clear();
      print(e);
    }
  }
}
