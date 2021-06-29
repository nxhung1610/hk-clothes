import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/contact.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  const ContactItem({key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(
      () => Badge(
        showBadge: contactController.selectContact.value.contactId ==
            contact.contactId,
        badgeContent: Icon(
          Icons.check,
          size: size.width * 0.05 > 15 ? 15 : size.width * 0.05,
          color: Colors.white,
        ),
        badgeColor: AppColors.app,
        child: GestureDetector(
          onTap: () {
            contactController.selectContact.value = contact;
            Get.back();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 5,
                  color: AppColors.app.shade400.withOpacity(0.2),
                )
              ],
              color: AppColors.app[200],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        contact.receiver,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.app,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      contact.phoneNumber,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.app.shade400,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  contact.address,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.app.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
