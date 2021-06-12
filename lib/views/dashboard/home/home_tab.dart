import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/views/dashboard/home/widgets/category_widget.dart';
import 'package:hk_clothes/views/dashboard/home/widgets/clothes_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: Text(
                  "SHOP BY CATEGORY",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
              ),
              itemCount: homeController.listCategory.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryItem(
                  categoryItem: homeController.listCategory[index],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: Text(
                  "TRENDING STYLES",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                height: size.width * (1 / 2),
                width: double.infinity,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) => ClothesItem(
                    size: size.width * (1 / 3),
                    clothes: null,
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: size.width * 0.02,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Center(
                child: Text(
                  "RECOMMENDED FOR YOU",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: 20,
                itemBuilder: (context, index) => ClothesItem(
                  size: size.width * (1 / 3),
                  clothes: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
