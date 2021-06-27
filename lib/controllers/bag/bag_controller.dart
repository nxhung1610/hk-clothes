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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    bag = Bag(productBags: []).obs;

    super.onReady();
  }

  Future addProductBag(ProductBag productBag) async {
    showLoading();
    if (productBag.sid == null) {
      dismissLoadingWidget();
      showSnackbar("Add Bag", "Please select Size Product", false);
      return;
    }
    var n =
        bag.value.productBags.where((element) => element.pid == productBag.pid);
    if (n.length == 0)
      bag.value.productBags.add(productBag);
    else
      n.first.number++;
    try {
      await refbag.set(bag.value.toJson());
      dismissLoadingWidget();
      showSnackbar("Add Bag", "Add Product to bag success", true);
    } catch (e) {
      dismissLoadingWidget();
      showSnackbar("Add Bag", "Add Product to bag failed", false);
    }
  }

  void fecthBagUser() {
    refbag = firestore
        .collection("users")
        .doc(authController.userInfor.value.uid)
        .collection("status")
        .doc("bag");
    refbag.snapshots().listen((event) {
      if (event.exists)
        bag.value = Bag.fromJson(event.data());
      else
        bag.value.productBags.clear();
    });
  }
}
