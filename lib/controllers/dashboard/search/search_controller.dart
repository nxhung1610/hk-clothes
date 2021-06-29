import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/product/product.dart';

class SearchController extends GetxController with  SingleGetTickerProviderMixin
{
  static SearchController instance = Get.find();

   RxBool isSearch =false.obs;

  Rx<FocusNode> myFocusNode =FocusNode().obs;

  final textController = TextEditingController();

  final scrollController = ScrollController();

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
          .collection("product_detail").where('product_name',isGreaterThanOrEqualTo: input.toUpperCase())
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
        .collection("product_detail").where('product_name',isGreaterThanOrEqualTo: input.toUpperCase())
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


