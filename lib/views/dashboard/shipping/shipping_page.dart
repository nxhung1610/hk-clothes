import 'package:flutter/material.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';

class ShippingPage extends StatelessWidget {
  const ShippingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      top: true,
      child: Scaffold(
        backgroundColor: AppColors.app[550],
        appBar: AppBar(
          backgroundColor: Colors.white,
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
            controller: shippingController.tabController,
            tabs: shippingController.listTabItem,
          ),
        ),
        body: TabBarView(
          controller: shippingController.tabController,
          children: shippingController.listTab,
        ),
      ),
    );
  }
}
