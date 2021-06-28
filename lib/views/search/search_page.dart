import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hk_clothes/constants/app_color.dart';
import 'package:hk_clothes/constants/controller.dart';
import 'package:hk_clothes/controllers/dashboard/search/search_controller.dart';
import 'package:hk_clothes/models/search.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                 /* searchController.isSearch.value=true;
                  searchController.myFocusNode.value.requestFocus();*/
                  showSearch(context: context, delegate: DataSearch());

                },
                icon: Icon(
                  Icons.search,
                  color: AppColors.app[400],
                ),
              ),
            ],
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 2,
            title: Obx(()=>!searchController.isSearch.value
                ? Text(
              "Search Here",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: AppColors.app[400],
              ),
            )
                : TextField(
              focusNode: searchController.myFocusNode.value,
              autofocus: true ,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Search Here'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: AppColors.app[400],
              ),
            ),)
          )),
    );
  }
}
