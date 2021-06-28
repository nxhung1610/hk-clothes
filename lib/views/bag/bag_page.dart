import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/views/bag/widgets/product_bag_item.dart';
import 'package:hk_clothes/views/product/widgets/product_widget.dart';

class BagPage extends StatelessWidget {
  const BagPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.app[550],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Bag",
          style: TextStyle(
            color: AppColors.app,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.app[200],
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
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                width: size.width,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.app[200],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Obx(() {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              // executes after build
                              bagController.resetWallet();
                            });

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    bagController.bag.value.productBags.length,
                                itemBuilder: (context, index) => ProductbagItem(
                                      productBag: bagController
                                          .bag.value.productBags[index],
                                      function: productController.showInforItem,
                                    ));
                          })
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.app[200],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Product(s) Total :',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${bagController.sumPrice.value} VND',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Discount(s) Total :',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${bagController.discountPrice.value} VND',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.app.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Estimated(s) Total :',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${bagController.sumPrice.value - bagController.discountPrice.value} VND',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
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
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Obx(
                    () => Text(
                      'Total : ${bagController.sumPrice.value - bagController.discountPrice.value} VND',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.app,
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Obx(
                        () => Text(
                          "SECURE CHECK OUT(${bagController.numberProductBag.value})",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
