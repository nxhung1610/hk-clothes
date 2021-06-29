import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';
import 'package:hk_clothes/views/contact/contact_infor_page.dart';
import 'package:hk_clothes/views/contact/widgets/contact_item.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.app.shade200,
        title: Text(
          "Select Shipping Address",
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
      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(15),
          itemCount: contactController.contacts.length,
          itemBuilder: (context, index) => ContactItem(
            contact: contactController.contacts[index],
          ),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 15,
            );
          },
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
                  onPressed: () {
                    Get.to(() => ContactInforPage());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "ADD NEW CONTACT",
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
