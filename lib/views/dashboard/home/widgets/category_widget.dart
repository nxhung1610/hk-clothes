import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/models/category.dart';
import 'package:hk_clothes/views/dashboard/home/category_page.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;
  const CategoryItem({Key key, @required this.categoryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 1,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: categoryItem.icon,
                  ),
                  Text(
                    categoryItem.name,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color:  Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.app[500].withOpacity(0.2),
                splashFactory: InkRipple.splashFactory,
                onTap: () {
                  Get.to(() => CategoryPage(
                        categoryItem: categoryItem,
                      ));
                },
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
