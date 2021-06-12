import 'package:flutter/material.dart';
import 'package:hk_clothes/views/dashboard/home/widgets/clothes_widget.dart';

class SaleTab extends StatelessWidget {
  const SaleTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: Padding(
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
                  itemCount: 60,
                  itemBuilder: (context, index) => ClothesItem(
                    size: size.width * (1 / 3),
                    clothes: null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
