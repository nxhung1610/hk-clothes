import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/controllers/auth/auth_controller.dart';
import 'package:hk_clothes/controllers/dashboard/account/updateinfo_controller.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateInfo extends StatelessWidget {
  const UpdateInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var param = Get.arguments;
    final controller = TextEditingController();
    DateTime currentDate = DateTime.now();
    String groupValue = '';

    Future<void> _selectDate(BuildContext context) async {
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
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                updateInfoController.getImage(ImageSource.gallery);
              },
              child: CircleAvatar(
                  radius: 100,
                  backgroundImage: authController
                          .userInfor.value.photoUrl.isEmpty
                      ? AssetImage('assets/images/logo_splash.png')
                      : NetworkImage(authController.userInfor.value.photoUrl)),
            ),
          );
          break;
        default:
          controller.text = value;
          return TextField(
            readOnly: (type == 6 || type == 5) ? true : false,
            onTap: () {
              switch (type) {
                case 6:
                  _selectDate(context);
                  break;
                case 5:
                  Get.defaultDialog(
                    title: "Choose Gender",
                    barrierDismissible: true,
                    content: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('male'),
                          leading: Radio(
                              value: 'Male',
                              groupValue: groupValue,
                              onChanged: (val) {
                                groupValue = val;
                              }),
                        ),
                        ListTile(
                          title: const Text('female'),
                          leading: Radio(
                            value: 'Female',
                            groupValue: groupValue,
                            onChanged: (val) {
                              groupValue = val;
                            },
                          ),
                        ),
                      ],
                    ),
                    textCancel: "Cancel",
                    textConfirm: "OK",
                    onCancel: () {},
                    onConfirm: () {},
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
                      onPressed: () {
                        switch (param[1]) {
                          case 1:
                            break;
                          case 2:
                            break;
                          case 3:
                            break;
                          case 4:
                            break;
                          case 5:
                            break;
                          case 6:
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
