import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_clothes/constants/app_color.dart';

class UpdateInfo extends StatelessWidget {


  const UpdateInfo({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var param = Get.arguments;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            param[0].toString(),
            style: TextStyle(

                color: AppColors.app[400],
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: AppColors.app[550],
          child: Column(
            children: [
              param[1]==1?Padding(
                padding: EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: (){},
                  child: CircleAvatar(
                    radius: 100,

                  ),
                ),
              ):
              TextField(
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: param[0],
                  fillColor: Colors.white,
                  filled:  true,
                  contentPadding: EdgeInsets.all(20)
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Done",
                          style: TextStyle(fontSize: 24),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
