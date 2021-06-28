import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/product/product.dart';

class CategoryController extends GetxController with SingleGetTickerProviderMixin
{
  static CategoryController instance = Get.find();

  final controller = ScrollController();



  void scrollUp()
  {
    final double start =0;
    controller.animateTo(start, duration: Duration(milliseconds: 800), curve: Curves.easeIn);
  }


  @override
  void onInit() {
    super.onInit();
    listProduct = <Product>[].obs;
  }

  Rx<bool> isLoading = false.obs;

  RxList<Product> listProduct;

  void refreshPage() {
    listProduct.clear();
  }


  Future fetchProducts(String input) async {
    if (isLoading.value) return;
    isLoading.value = true;
    try{
      var result = await firestore
          .collection("shopstore")
          .doc("products")
          .collection("product_detail").where('type',isEqualTo: input)
          .limit(9)
          .get();
      result.docs.forEach((element) {
        listProduct.add(Product.fromJson(element.data()));
      });
    }
    catch(e)
    {

    }
    isLoading.value = false;
  }


  Future fetchProductsNext(String input) async {
    if (isLoading.value) return;
    isLoading.value = true;
    try{var result = await firestore
        .collection("shopstore")
        .doc("products")
        .collection("product_detail").where('type',isEqualTo: input)
        .orderBy("pid")
        .startAfter([listProduct[listProduct.length - 1].pid])
        .limit(9)
        .get();
    result.docs.forEach((element) {
      listProduct.add(Product.fromJson(element.data()));
    });}
    catch(e)
    {


    }
    isLoading.value = false;
  }


}