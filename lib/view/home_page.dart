import 'dart:convert';

import 'package:api_app/api_service/api_service.dart';
import 'package:api_app/view/serch_bar.dart';
import 'package:api_app/view/serch_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future getData() async {
    http.Response response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    var result = jsonDecode(response.body);
    print('Response===>>${jsonDecode(response.body)}');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('username').then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    ),
                  );
            },
            leading: Text('Log Out', textScaleFactor: 1.5),
            trailing: Icon(Icons.exit_to_app, size: 30),
          ),
        )),
        appBar: AppBar(title: Text('Fashion')),
        body: FutureBuilder(
          future: ApiServices.getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        snapshot.data[index]['image'],
                      ),
                    ),
                    title: Text(snapshot.data[index]['title']),
                    subtitle: Text(snapshot.data[index]['price'].toString()),
                    trailing: Column(
                      children: [
                        Text(snapshot.data[index]['rating'].toString()),
                        Text(snapshot.data[index]['categories'].toString()),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
