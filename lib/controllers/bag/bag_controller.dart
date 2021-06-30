import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/bag/bag.dart';
import 'package:hk_clothes/models/bag/product_bag.dart';
import 'package:hk_clothes/utils/helpers/show_loading.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';

class BagController extends GetxController {
  static BagController instance = Get.find();
  Rx<Bag> bag;
  DocumentReference refbag;
  RxInt sumPrice;
  RxInt discountPrice;
  RxInt numberProductBag;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    bag = Bag(productBags: []).obs;
    sumPrice = 0.obs;
    discountPrice = 0.obs;
    numberProductBag = 0.obs;
    super.onReady();
  }

  void resetWallet() {
    sumPrice.value = 0;
    discountPrice.value = 0;
  }

  Future addProductBag(ProductBag productBag) async {
    showLoading();
    if (productBag.sid == null) {
      dismissLoadingWidget();
      showSnackbar("Add Bag", "Please select Size Product", false);
      return;
    }
    var n = bag.value.productBags.where((element) =>
        element.pid == productBag.pid && element.sid == productBag.sid);
    if (n.length == 0)
      bag.value.productBags.add(productBag);
    else
      n.first.number++;
    try {
      await refbag.set(bag.value.toJson()).timeout(Duration(seconds: 30),
          onTimeout: () {
        dismissLoadingWidget();
        throw Exception();
      });
      dismissLoadingWidget();
      showSnackbar("Add Bag", "Add Product to bag success", true);
    } catch (e) {
      dismissLoadingWidget();
      showSnackbar("Add Bag", "Add Product to bag failed", false);
    }
  }

  Future delProductBag(ProductBag productBag) async {
    showLoading();
    if (productBag.sid == null) {
      dismissLoadingWidget();
      showSnackbar("Delete Product", "Delete product failed", false);
      return;
    }

    bag.value.productBags.removeWhere((element) =>
        element.pid == productBag.pid && element.sid == productBag.sid);

    try {
      await refbag.set(bag.value.toJson()).timeout(Duration(seconds: 30),
          onTimeout: () {
        dismissLoadingWidget();
        throw Exception();
      });
      dismissLoadingWidget();
      showSnackbar("Delete Product", "Delete Product from bag success", true);
    } catch (e) {
      dismissLoadingWidget();
      showSnackbar("Delete Product", "Delete Product from bag success", false);
    }
  }

  Future<bool> clearProductBag() async {
    showLoading();
    try {
      await refbag
          .set(Bag(productBags: []).toJson())
          .timeout(Duration(seconds: 30), onTimeout: () {
        dismissLoadingWidget();
        throw Exception();
      });
      dismissLoadingWidget();
      return true;
    } catch (e) {
      dismissLoadingWidget();
      return false;
    }
  }

  Future incrNumProduct(ProductBag productBag) async {
    showLoading();
    if (productBag.sid == null) {
      dismissLoadingWidget();
      showSnackbar("Add Product", "Please select Size Product", false);
      return;
    }

    var n = bag.value.productBags.where((element) =>
        element.pid == productBag.pid && element.sid == productBag.sid);
    if (n.length == 0) {
      dismissLoadingWidget();
      showSnackbar("Add Product", "Some thing errors", false);
      return;
    }

    n.first.number++;

    try {
      await refbag.set(bag.toJson()).timeout(Duration(seconds: 30),
          onTimeout: () {
        dismissLoadingWidget();
        throw Exception();
      });
      dismissLoadingWidget();
      showSnackbar("Add Product", "Increase success", true);
    } catch (e) {
      n.first.number = n.first.number - 1;
      dismissLoadingWidget();
      showSnackbar("Add Product", "Increase failed", false);
    }
  }

  Future decrNumProduct(ProductBag productBag) async {
    showLoading();
    if (productBag.sid == null) {
      dismissLoadingWidget();
      showSnackbar("Add Product", "Please select Size Product", false);
      return;
    }

    var n = bag.value.productBags.where((element) =>
        element.pid == productBag.pid && element.sid == productBag.sid);
    if (n.length == 0) {
      dismissLoadingWidget();
      showSnackbar("Decrease Product", "Some thing errors", false);
      return;
    }

    if (n.first.number == 1) {
      dismissLoadingWidget();
      return;
    }
    n.first.number = n.first.number - 1;

    try {
      await refbag.set(bag.toJson());
      dismissLoadingWidget();
      showSnackbar("Decrease Product", "Increase success", true);
    } catch (e) {
      n.first.number++;
      dismissLoadingWidget();
      showSnackbar("Decrease Product", "Increase failed", false);
    }
  }

  void fecthBagUser() {
    refbag = firestore
        .collection("users")
        .doc(authController.userInfor.value.uid)
        .collection("status")
        .doc("bag");
    refbag.snapshots().listen((event) {
      resetWallet();
      if (event.exists) {
        bag.value = Bag.fromJson(event.data());
        if (bag.value.productBags == null) bag.value.productBags = [];

        numberProductBag.value = bag.value.productBags.length != 0
            ? bag.value.productBags
                .map((e) => e.number)
                .reduce((value, element) => value + element)
            : 0;
      } else
        bag.value.productBags.clear();
    });
  }
}
