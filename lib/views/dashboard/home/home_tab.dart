import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hk_clothes/constants/assets.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/views/dashboard/home/widgets/category_widget.dart';

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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}
