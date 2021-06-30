import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/models/contact.dart';
import 'package:hk_clothes/utils/helpers/show_loading.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';

class ContactController extends GetxController {
  static ContactController instance = Get.find();
  RxList<Contact> contacts;
  Rx<Contact> selectContact;
  TextEditingController fullNameController,
      phoneNumberController,
      addressController;

  @override
  void onInit() {
    super.onInit();
    contacts = <Contact>[].obs;
    selectContact = Contact().obs;
    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  void resetController() {
    fullNameController.clear();
    phoneNumberController.clear();
    addressController.clear();
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

  int validContact() {
    RegExp validFullName = RegExp(
        "^([a-zA-Z]{2,}\\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\\s?([a-zA-Z]{1,})?)");
    RegExp validPhone = RegExp("((09|03|07|08|05)+([0-9]{8})\\b)");
    RegExp validAddress = RegExp("^.{5,}\$");
    if (!validFullName.hasMatch(fullNameController.text)) return 1;
    if (!validPhone.hasMatch(phoneNumberController.text)) return 2;
    if (!validAddress.hasMatch(addressController.text)) return 3;
    return 0;
  }

  Future<bool> addContact(Contact contact) async {
    showLoading();
    try {
      await firestore
          .collection('users')
          .doc(authController.userInfor.value.uid)
          .collection('contacts')
          .doc(contact.contactId)
          .set(contact.toJson())
          .timeout(Duration(seconds: 30), onTimeout: () {
        dismissLoadingWidget();
        throw Exception();
      });
      dismissLoadingWidget();
    } catch (e) {
      dismissLoadingWidget();
      return false;
    }
    return true;
  }
}
