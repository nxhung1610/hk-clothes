import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/user/contact.dart';

class ContactController extends GetxController {
  static ContactController instance = Get.find();
  RxList<Contact> contacts;
  Rx<Contact> selectContact;

  @override
  void onInit() {
    super.onInit();
    contacts = <Contact>[].obs;
    selectContact = Contact().obs;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future fetchDataContact() async {
    firestore
        .collection("users")
        .doc(authController.userInfor.value.uid)
        .collection('contacts')
        .snapshots()
        .listen((event) {
      if (event.isBlank) return;
      contacts.clear();
      contacts.addAll(event.docs.map((e) => Contact.fromJson(e.data())));
      if (contacts.length != 0) selectContact.value = contacts.first;
    });
  }
}
