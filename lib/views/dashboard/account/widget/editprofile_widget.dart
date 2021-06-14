import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hk_clothes/constants/firebase.dart';
import 'package:hk_clothes/controllers/auth/auth_controller.dart';
import 'package:hk_clothes/models/user_infor.dart';

class EditProfile extends StatelessWidget {
  final String title;
  final Widget widget;
  final  function;
  EditProfile({Key key,@required this.title,@required  this.widget,@required this.function}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Get.toNamed('/updateinfo',arguments: [title,function]),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            widget,
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
