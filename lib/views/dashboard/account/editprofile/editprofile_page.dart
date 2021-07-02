import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/controllers/auth/auth_controller.dart';
import 'package:hk_clothes/views/dashboard/account/widget/editprofile_widget.dart';
import 'package:shimmer/shimmer.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
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
                Get.back();
              },
            ),
          ),
        ),
      ),
      //container , padding , row
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.app[550],
          child: Container(
            color: Colors.white,
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EditProfile(
                      title: "Change your photo",
                      value: authController.userInfor.value.photoUrl,
                      widget: CachedNetworkImage(
                        imageUrl: authController.userInfor.value.photoUrl ??
                            "https://www.google.com/",
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 40,
                          backgroundImage: imageProvider,
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage("assets/icon/icon.png"),
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.app,
                          ),
                          baseColor: AppColors.app[550],
                          highlightColor: Colors.grey[100],
                        ),
                      ),
                      function: 1),
                  Divider(thickness: 2),
                  EditProfile(
                    title: "First Name",
                    value: authController.userInfor.value.firstName,
                    widget: Text(authController.userInfor.value.firstName,
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.app[500],
                            fontWeight: FontWeight.bold)),
                    function: 2,
                  ),
                  Divider(thickness: 2),
                  EditProfile(
                      title: "Last Name",
                      value: authController.userInfor.value.lastName,
                      widget: Text(authController.userInfor.value.lastName,
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.app[500],
                              fontWeight: FontWeight.bold)),
                      function: 3),
                  Divider(thickness: 2),
                  EditProfile(
                      title: "Nickname",
                      value: authController.userInfor.value.nickname,
                      widget: Text(authController.userInfor.value.nickname,
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.app[500],
                              fontWeight: FontWeight.bold)),
                      function: 4),
                  Divider(thickness: 2),
                  EditProfile(
                      title: "Gender",
                      value: authController.userInfor.value.gender,
                      widget: Text(authController.userInfor.value.gender,
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.app[500],
                              fontWeight: FontWeight.bold)),
                      function: 5),
                  Divider(thickness: 2),
                  EditProfile(
                      title: "Birthday",
                      value: authController.userInfor.value.birthday,
                      widget: Text(authController.userInfor.value.birthday,
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.app[500],
                              fontWeight: FontWeight.w600)),
                      function: 6),
                  Divider(thickness: 2),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            authController.signOut();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "Logout",
                              style: TextStyle(fontSize: 24),
                            ),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
