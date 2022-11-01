import 'package:api_app/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service/login_service.dart';
import '../model/login_model.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();

  final passWord = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? userName;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "user name can not be empty";
                          }
                        },
                        controller: username,
                        decoration: InputDecoration(
                          hintText: 'Username',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "user name can not be empty";
                          }
                        },
                        controller: passWord,
                        decoration: InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              LoginMadel model = LoginMadel();
                              model.username = username.text;
                              model.password = passWord.text;
                              setState(() {
                                isLoading = true;
                              });
                              bool? status =
                                  await LoginService.loginUser(model.toJson());

                              if (status == true) {
                                setState(() {
                                  isLoading = false;
                                });

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text('Succesfully Log in'),
                                      ),
                                    )
                                    .closed
                                    .then(
                                      (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      ),
                                    );
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 1),
                                    content: Text('Log in Failed'),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text("Log in"))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
