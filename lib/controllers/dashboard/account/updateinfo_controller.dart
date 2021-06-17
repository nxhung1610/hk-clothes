import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';
import 'package:image_picker/image_picker.dart';

class UpdateInfoController extends GetxController
    with SingleGetTickerProviderMixin {
  static UpdateInfoController instance = Get.find();
  var selectedImagePath = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else
      showSnackbar("Error", "No image selected", false);
  }
}
