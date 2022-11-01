import 'dart:async';

import 'package:api_app/view/home_page.dart';
import 'package:api_app/view/serch_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userName;
  @override
  void initState() {
    getUserName().whenComplete(() => Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    userName == null ? SignUpScreen() : const HomePage(),
              )),
        ));

    super.initState();
  }

  Future getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('username');
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SpleshScreen', textScaleFactor: 3),
      ),
    );
  }
}
