import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/models/category.dart';
import 'package:hk_clothes/views/product/widgets/product_widget.dart';

class CategoryPage extends StatelessWidget {
  final Category categoryItem;

  const CategoryPage({Key key, @required this.categoryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onScroll() {
      if (categoryController.controller.offset >=
              categoryController.controller.position.maxScrollExtent &&
          !categoryController.controller.position.outOfRange) {
        if (categoryController.listProduct.length != 0)
          categoryController.fetchProductsNext(categoryItem.type);
        else
          categoryController.fetchProducts(categoryItem.type);
      }
    }

    categoryController.controller.addListener(_onScroll);

    categoryController.refreshPage();
    if (categoryController.listProduct.length == 0)
      categoryController.fetchProducts(categoryItem.type);
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
              onPressed: () {
                Get.toNamed('/bag');
              },
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
        body: RefreshIndicator(
          onRefresh: () async {
            categoryController.refreshPage();
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => categoryController.fetchProducts(categoryItem.type));
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            controller: categoryController.controller,
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Obx(() => categoryController.listProduct.length != 0
                    ? Container(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.66,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: categoryController.listProduct != null
                              ? categoryController.listProduct.length
                              : 0,
                          itemBuilder: (context, index) {
                            return ProductItem(
                              size: size.width * (1 / 3),
                              clothes: categoryController.listProduct[index],
                              function: productController.showInforItem,
                            );
                          },
                        ),
                      )
                    : Container()),
                Obx(
                  () => !categoryController.isLoading.value
                      ? Container()
                      : Center(
                          child: SpinKitWave(
                            size: 30,
                            color: AppColors.app[500],
                          ),
                        ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
