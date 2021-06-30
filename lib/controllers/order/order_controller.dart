import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/order/order.dart';
import 'package:hk_clothes/utils/helpers/show_loading.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  RxList<Order> orders;

  @override
  void onInit() {
    super.onInit();
    orders = <Order>[].obs;
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

  void fetchDataOrders() async {
    firestore
        .collection("users")
        .doc(authController.userInfor.value.uid)
        .collection("orders")
        .snapshots()
        .listen((event) {
      orders.clear();
      orders.addAll(event.docs.map((e) => Order.fromJson(e.data())).toList());
    });
  }
}
