import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SnakeShape snakeShape = SnakeShape(
        padding: EdgeInsets.all(5),
        centered: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ));
    ShapeBorder bottomBarShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)));

    SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

    EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: size.width * 0.17, vertical: 10);

    return Obx(
      () => Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        bottomNavigationBar: SnakeNavigationBar.color(
          elevation: 1.5,
          shadowColor: AppColors.app[100],
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          snakeViewColor: AppColors.app,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? AppColors.app[400] : null,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: dashBoardController.selectItemBottom.value,
          onTap: dashBoardController.changeSelectItemBottom,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping),
              label: 'bag',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'account',
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: IndexedStack(
            index: dashBoardController.selectItemBottom.value,
            children: dashBoardController.pageList,
          ),
        ),
      ),
    );
  }
}
