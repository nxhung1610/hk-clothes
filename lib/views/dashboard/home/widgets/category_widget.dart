import 'package:flutter/material.dart';
import 'package:hk_clothes/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category categoryItem;
  const CategoryItem({Key key, @required this.categoryItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: categoryItem.icon,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                categoryItem.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
