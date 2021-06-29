import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/controllers/dashboard/search/search_controller.dart';
import 'package:hk_clothes/views/dashboard/account/widget/editprofile_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => searchWidgetState();
}

class searchWidgetState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;
  bool isforward = false;

  Tween<double> tween;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: (this), duration: Duration(seconds: 1));

    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOutExpo);

    tween = Tween<double>(begin: 0, end: 150);

    animation = tween.animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        animationController.forward();
        isforward = true;
      });

    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    tween.end = size.width - size.width*0.3;

    return Scaffold(
      extendBodyBehindAppBar: true,

      body: SafeArea(
        top: true,
        
        child: Container(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(size.width*0.01),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.app.shade100,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: size.width*0.04,),
                        width: animation.value,

                        child: TextField(
                          cursorColor: Colors.white12,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {

                        },
                      )
                    ],
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
