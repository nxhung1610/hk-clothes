import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final cities = [
    "mot",
    "hai",
    "ba",
    "bon",
    "nam",
  ];

  final recent = [
    "mot",
    "hai",
    "ba",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query="";

    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final sugestionList = query.isEmpty ? recent : cities;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(
          sugestionList[index],
        ),
      ),
      itemCount: sugestionList.length,
    );
  }
}
