import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/order.dart';
import 'package:hk_clothes/utils/helpers/show_loading.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<bool> orderProducts(Order order) async {
    showLoading();
    try {
      await firestore
          .collection("users")
          .doc(authController.userInfor.value.uid)
          .collection("orders")
          .doc(order.orderId)
          .set(order.toJson())
          .timeout(
        Duration(seconds: 30),
        onTimeout: () {
          dismissLoadingWidget();
          return false;
        },
      );
    } catch (e) {
      dismissLoadingWidget();
      return false;
    }
    dismissLoadingWidget();

    return await bagController.clearProductBag();
  }
}
