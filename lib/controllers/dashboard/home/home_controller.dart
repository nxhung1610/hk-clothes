import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/assets.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/category.dart';
import 'package:hk_clothes/models/product/product.dart';
import 'package:hk_clothes/models/product/product_sale.dart';
import 'package:hk_clothes/views/dashboard/home/home_tab.dart';
import 'package:hk_clothes/views/dashboard/home/sale_tab.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  static HomeController instance = Get.find();

  // Tab place
  final listTabItem = [
    Tab(
      text: "Home",
    ),
    Tab(
      text: "Sale",
    ),
  ];
  final listTab = [
    HomeTab(),
    SaleTab(),
  ];
  TabController tabController;

  // Category
  final listCategory = [
    Category(name: "Shirt", icon: categoryShirt,type: "1"),
    Category(name: "T-Shirt", icon: categoryTShirt,type: "2"),
    Category(name: "Hoodies", icon: categoryHoodie,type: "3"),
    Category(name: "Short", icon: categoryShort,type: "4"),
    Category(name: "Pants", icon: categoryPants,type: "5"),
    Category(name: "Sweatshirt", icon: categorySweatshirt,type: "6"),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: listTabItem.length);
    listProductRecommand = <Product>[].obs;
    listProductTrending = <Product>[].obs;
    listProductSale = <Product>[].obs;
  }

  //Refresh data
  void refreshDataHomeTab() {
    listProductRecommand.clear();
    listProductTrending.clear();
  }

  void refreshDataSaleTab() {
    listProductSale.clear();
  }

  // Loading data Recommand
  Rx<bool> isLoadingRecommand = false.obs;

  RxList<Product> listProductRecommand;

  Future fetchProductsRecommand() async {
    if (isLoadingRecommand.value) return;
    isLoadingRecommand.value = true;
    var result = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_detail")
        .limit(9)
        .get();
    result.docs.forEach((element) {
      listProductRecommand.add(Product.fromJson(element.data()));
    });
    isLoadingRecommand.value = false;
  }

  Future fetchProductsRecommandNext() async {
    if (isLoadingRecommand.value) return;
    isLoadingRecommand.value = true;
    var result = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_detail")
        .orderBy("pid")
        .startAfter([listProductRecommand[listProductRecommand.length - 1].pid])
        .limit(9)
        .get();
    result.docs.forEach((element) {
      listProductRecommand.add(Product.fromJson(element.data()));
    });
    isLoadingRecommand.value = false;
  }

  // loading data trending
  Rx<bool> isLoadingTrending = false.obs;

  RxList<Product> listProductTrending;

  Future fetchProductsTrending() async {
    if (isLoadingTrending.value) return;
    isLoadingTrending.value = true;
    var result = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_detail")
        .limit(9)
        .get();
    result.docs.forEach((element) {
      listProductTrending.add(Product.fromJson(element.data()));
    });
    isLoadingTrending.value = false;
  }

  // Loading data sale
  Rx<bool> isLoadingSale = false.obs;

  RxList<Product> listProductSale;

  Future fetchProductsSale() async {
    if (isLoadingSale.value) return;
    isLoadingSale.value = true;
    var result = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_sale")
        .limit(9)
        .get();
    result.docs.forEach((element) async {
      final i = ProductSale.fromJson(element.data());
      final k = await firestore
          .collection("shopstore")
          .doc("products")
          .collection("product_detail")
          .where("pid", isEqualTo: i.pid)
          .get();
      if (k.docs[0].exists)
        listProductSale.add(Product.fromJson(k.docs[0].data()));
    });
    isLoadingSale.value = false;
  }
}
