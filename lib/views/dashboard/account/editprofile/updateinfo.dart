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

    Future<void> _showMyDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Radio(
                        activeColor: Theme.of(context).primaryColor,
                        value: 0,
                        onChanged: (value) {
                          controller.text = value;
                        },
                      ),
                      Text("Male")
                    ],
                  ), Row(
                    children: [
                      Radio(
                        activeColor: Theme.of(context).primaryColor,
                        value: 1,
                        onChanged: (value) {
                          controller.text = value;
                        },
                      ),
                      Text("Female")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Theme.of(context).primaryColor,
                        value: 2,
                        onChanged: (value) {
                          controller.text = value;
                        },
                      ),
                      Text("Others")
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Confirm'),
                onPressed: () {
                  print('Confirmed');
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
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
              param[1] == 1
                  ? Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          updateInfoController.getImage(ImageSource.gallery);
                        },
                        child: CircleAvatar(
                            radius: 100,
                            backgroundImage: AuthController
                                    .userInfor.photoUrl.isEmpty
                                ? AssetImage('assets/images/logo_splash.png')
                                : NetworkImage(
                                    AuthController.userInfor.photoUrl)),
                      ),
                    )
                  : TextField(
                      readOnly: (param[1] == 6 || param[1] == 5) ? true : false,
                      onTap: () {
                        switch (param[1]) {
                          case 6:
                            _selectDate(context);

                            break;
                          case 5:
                            _showMyDialog(context);
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
                    ),
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
