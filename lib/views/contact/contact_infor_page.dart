import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/contact.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';
import 'package:uuid/uuid.dart';

class ContactInforPage extends StatelessWidget {
  const ContactInforPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.app[550],
      appBar: AppBar(
        backgroundColor: AppColors.app.shade200,
        title: Text(
          "Add New Address",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.app,
          ),
        ),
        centerTitle: true,
        leading: Container(
          width: 25,
          height: 25,
          padding: EdgeInsets.all(5),
          child: Ink(
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: CircleBorder(),
            ),
            child: IconButton(
              splashRadius: 25,
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.app[100],
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: contactController.fullNameController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Full Name',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(20)),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: contactController.phoneNumberController,
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(20)),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: contactController.addressController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(20)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            color: AppColors.app.shade200,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.app,
                  ),
                  onPressed: () async {
                    switch (contactController.validContact()) {
                      case 0:
                        final contact = Contact(
                          contactId: Uuid().v1(),
                          receiver: contactController.fullNameController.text,
                          phoneNumber:
                              contactController.phoneNumberController.text,
                          address: contactController.addressController.text,
                        );

                        if (await contactController.addContact(contact)) {
                          contactController.resetController();
                          Get.back();
                          showSnackbar("Add Contact", "Success", true);
                        } else
                          showSnackbar("Add Contact", "Failed", false);
                        break;
                      case 1:
                        showActionSnackBar(context, 'Full Name is not valid');
                        break;
                      case 2:
                        showActionSnackBar(
                            context, 'Phone number is not valid(Viet Nam)');
                        break;
                      case 3:
                        showActionSnackBar(context, 'Address is not valid');
                        break;
                      default:
                        showActionSnackBar(context, 'Some thing error');
                        break;
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
