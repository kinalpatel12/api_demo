import 'package:api_app/model/sign_up_model.dart';
import 'package:api_app/view/all_user_page.dart';
import 'package:api_app/view/get_with_model.dart';
import 'package:api_app/view/home_page.dart';
import 'package:api_app/view/login_page.dart';
import 'package:api_app/view/serch_bar.dart';
import 'package:api_app/view/serch_product.dart';
import 'package:api_app/view/sign_precties.dart';
import 'package:api_app/view/splesh_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetWithModel(),
      debugShowCheckedModeBanner: false,
    );
  }
}
