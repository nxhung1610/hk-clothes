import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      top: true,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColors.app[400],
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed('/bag');
              },
              icon: Icon(
                Icons.shopping_bag,
                color: AppColors.app[400],
              ),
            ),
          ],
          elevation: 2,
          title: Text(
            "Hyber King",
            style: TextStyle(
              fontFamily: "Elowen",
              fontSize: 30,
              color: AppColors.app[400],
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelPadding: EdgeInsets.zero,
            labelStyle: TextStyle(
              fontSize: 18,
              fontFamily: "UbuntuMono",
              fontWeight: FontWeight.bold,
            ),
            labelColor: AppColors.app,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                  width: 4.0,
                  style: BorderStyle.solid,
                  color: AppColors.app[400]),
              insets: EdgeInsets.symmetric(horizontal: size.width * 0.12),
            ),
            controller: homeController.tabController,
            tabs: homeController.listTabItem,
          ),
        ),
        body: TabBarView(
          controller: homeController.tabController,
          children: homeController.listTab,
        ),
      ),
    );
  }
}
