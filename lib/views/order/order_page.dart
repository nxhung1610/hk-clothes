import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/utils/helpers/show_snackbar.dart';
import 'package:hk_clothes/views/order/widgets/item_product.dart';

class OrderInforPage extends StatefulWidget {
  OrderInforPage({key}) : super(key: key);

  @override
  _OrderInforPageState createState() => _OrderInforPageState();
}

class _OrderInforPageState extends State<OrderInforPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.app[550],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Informations",
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
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowGlow();
                return;
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('llll');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.app[200],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Obx(
                                () => contactController
                                            .selectContact.value.contactId !=
                                        null
                                    ? Column(
                                        children: [],
                                      )
                                    : Text(
                                        "Please add your contact",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.app.shade400,
                                        ),
                                      ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.app.shade500,
                              size: size.width * 0.1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                            'Online Payment',
                            style: TextStyle(
                              color: Colors.green.withAlpha(500),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Paypal',
                            style: TextStyle(
                              color: AppColors.app.shade400,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.app[200],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${bagController.numberProductBag.value} Items',
                              style: TextStyle(
                                color: AppColors.app,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => bagController
                                          .bag.value.productBags.length !=
                                      0
                                  ? Container(
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio: 0.8,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                        ),
                                        itemCount: bagController
                                                    .bag.value.productBags !=
                                                null
                                            ? bagController
                                                .bag.value.productBags.length
                                            : 0,
                                        itemBuilder: (context, index) {
                                          return ItemOrderProduct(
                                            size: size.width * (1 / 3),
                                            productBag: bagController
                                                .bag.value.productBags[index],
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      child: Text(
                                        "Nothing in your bag",
                                        style: TextStyle(
                                          color: AppColors.app.shade400,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (context) => Container(
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.app,
                  ),
                  onPressed: () {
                    if (contactController.selectContact.value.contactId !=
                        null) {
                    } else
                      showActionSnackBar(context, 'Please add your contact');
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "PLACE ORDER",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
