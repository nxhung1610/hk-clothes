import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/utils/helpers/show_loading.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';
import 'package:image_picker/image_picker.dart';

enum Gender { male, female }

class UpdateInfoController extends GetxController
    with SingleGetTickerProviderMixin {
  static UpdateInfoController instance = Get.find();
  Rx<Uint8List> selectedImage = Uint8List(0).obs;
  bool checkLoadImage = false;

  Rx<Gender> groupValue = Gender.male.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      checkLoadImage = true;
      selectedImage.value = await pickedFile.readAsBytes();
    } else
      showSnackbar("Error", "No image selected", false);
  }

  Future<String> uploadAvatar() async {
    showLoading();
    var data = selectedImage.value;

    try {
      var n = firebaseStorage
          .ref("users")
          .child(authController.userInfor.value.uid);
      await n.putData(data).timeout(Duration(seconds: 30), onTimeout: () {
        dismissLoadingWidget();
        throw Exception();
      });
      dismissLoadingWidget();

      return await n.getDownloadURL();
    } catch (e) {
      dismissLoadingWidget();

      return null;
    }
  }
}
