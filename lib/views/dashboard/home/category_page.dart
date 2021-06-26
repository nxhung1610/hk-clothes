import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/category.dart';
import 'package:hk_clothes/views/product/widgets/product_widget.dart';

class CategoryPage extends StatelessWidget {
  final Category categoryItem;

  const CategoryPage({Key key, @required this.categoryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      top: true,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          onPressed: () {
            categoryController.scrollUp();
          },
          child: Icon(Icons.arrow_upward_sharp),
          backgroundColor: AppColors.app.shade500,
        ),
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_bag,
                color: AppColors.app[400],
              ),
            ),
          ],
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 2,
          title: Text(
            categoryItem.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: AppColors.app[400],
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: GridView.builder(
            controller: categoryController.controller,
            padding: EdgeInsets.symmetric(horizontal: 5),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.66,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: homeController.listProductRecommand != null
                ? homeController.listProductRecommand.length
                : 0,
            itemBuilder: (context, index) {
              // print(homeController.listProductRecommand[index]
              //     .toJson());
              return ProductItem(
                size: size.width * (1 / 3),
                clothes: homeController.listProductRecommand[index],
                function: productController.showInforItem,
              );
            },
          ),
        ),
      ),
    );
  }
}
