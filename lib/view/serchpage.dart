import 'package:flutter/material.dart';

import '../api_service/api_service.dart';

class SearchBar extends SearchDelegate {
  // List<String> items = [
  //   "India",
  //   "US",
  //   "China",
  //   "UK",
  //   "Australia",
  //   "Japan",
  // ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        color: Colors.grey.shade300,
        child: Center(child: Text(query)),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? ApiServices.productList
        : ApiServices.productList!
            .where((element) => element['title']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestionList!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            showResults(context);
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(suggestionList[index]['image']),
          ),
          title: Text(
            suggestionList[index]['title'],
          ),
          subtitle: Text(
            suggestionList[index]['price'].toString(),
          ),
        );
      },
    );
  }
}
