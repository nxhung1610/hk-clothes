import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/controllers/auth/auth_controller.dart';
import 'package:hk_clothes/controllers/dashboard/account/updateinfo_controller.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateInfo extends StatelessWidget {
  const UpdateInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var param = Get.arguments;
    final controller = TextEditingController();
    DateTime currentDate;

    Future<void> _selectDate() async {
      final DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(1900),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != currentDate) {
        currentDate = pickedDate;
        DateFormat formatter = DateFormat('dd-MM-yyyy');
        String formatted = formatter.format(currentDate);
        controller.text = formatted;
      }
    }

    Widget input(BuildContext context, int type, String value) {
      switch (type) {
        case 1:
          return Obx(() {
            return Padding(
              padding: EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  updateInfoController.getImage(ImageSource.gallery);
                },
                child: CircleAvatar(
                    radius: 100,
                    backgroundColor: AppColors.app,
                    backgroundImage: updateInfoController
                                .selectedImage.value.length !=
                            0
                        ? MemoryImage(updateInfoController.selectedImage.value)
                        : authController.userInfor.value.photoUrl.isEmpty
                            ? AssetImage('assets/icon/icon.png')
                            : NetworkImage(
                                authController.userInfor.value.photoUrl)),
              ),
            );
          });
          break;
        default:
          controller.text = value;
          return TextField(
            readOnly: (type == 6 || type == 5) ? true : false,
            onTap: () {
              switch (type) {
                case 6:
                  try {
                    currentDate = DateTime.parse(param[2]);
                  } catch (e) {
                    currentDate = DateTime.now();
                  }
                  _selectDate();
                  break;
                case 5:
                  Get.defaultDialog(
                    title: "Choose Gender",
                    barrierDismissible: true,
                    content: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                              Radio(
                                  activeColor: AppColors.app.shade400,
                                  value: Gender.male,
                                  groupValue:
                                      updateInfoController.groupValue.value,
                                  onChanged: (val) {
                                    updateInfoController.groupValue.value =
                                        Gender.male;
                                  }),
                              Text("Male"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  activeColor: AppColors.app.shade400,
                                  value: Gender.female,
                                  groupValue:
                                      updateInfoController.groupValue.value,
                                  onChanged: (val) {
                                    updateInfoController.groupValue.value =
                                        Gender.female;
                                  }),
                              Text("Female"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    textCancel: "Cancel",
                    textConfirm: "OK",
                    onCancel: () {
                      updateInfoController.groupValue.value =
                          authController.userInfor.value.gender == 'male'
                              ? Gender.male
                              : Gender.female;
                    },
                    onConfirm: () {
                      controller.text = updateInfoController.groupValue.value
                          .toString()
                          .split('.')
                          .last;
                      Get.back();
                    },
                  );

                  break;
              }
            },
            controller: controller,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: param[0],
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(20)),
          );
      }
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            param[0].toString(),
            style: TextStyle(
                color: AppColors.app[400],
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          leading: Container(
            width: 25,
            height: 25,
            padding: EdgeInsets.all(5),
            child: Ink(
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: CircleBorder(),
              ),
              child: IconButton(
                splashRadius: 25,
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.app[100],
                ),
                onPressed: () {
                  updateInfoController.selectedImage.value = Uint8List(0);
                  Get.back();
                },
              ),
            ),
          ),
        ),
        body: Container(
          color: AppColors.app[550],
          child: Column(
            children: [
              input(context, param[1], param[2]),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () async {
                        switch (param[1]) {
                          case 1:
                            if (updateInfoController
                                    .selectedImage.value.length !=
                                0) {
                              String url =
                                  await updateInfoController.uploadAvatar();
                              Get.back();
                              if (url != null) {
                                authController.userInfor.value.photoUrl = url;

                                showSnackbar("Upload Avatar",
                                    "Success upload Avatar", true);
                              } else
                                showSnackbar(
                                    "Upload Avatar", "Failed to upload", false);
                            }

                            continue update;
                          case 2:
                            authController.userInfor.value.firstName =
                                controller.text;
                            Get.back();
                            continue update;
                          case 3:
                            authController.userInfor.value.lastName =
                                controller.text;
                            Get.back();
                            continue update;

                          case 4:
                            authController.userInfor.value.nickname =
                                controller.text;
                            Get.back();
                            continue update;

                          case 5:
                            authController.userInfor.value.gender =
                                updateInfoController.groupValue.value
                                    .toString()
                                    .split('.')
                                    .last;
                            Get.back();
                            continue update;
                          case 6:
                            authController.userInfor.value.birthday =
                                controller.text;
                            Get.back();
                            continue update;

                          update:
                          default:
                            authController.userInfor.refresh();
                            updateInfoController.selectedImage.value =
                                Uint8List(0);

                            break;
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Done",
                          style: TextStyle(fontSize: 24),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
