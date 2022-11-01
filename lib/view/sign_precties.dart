import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignPrectice extends StatefulWidget {
  const SignPrectice({Key? key}) : super(key: key);

  @override
  _SignPrecticeState createState() => _SignPrecticeState();
}

class _SignPrecticeState extends State<SignPrectice> {
  final username = TextEditingController();
  final password = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "username is can not be empty";
              }
            },
            controller: username,
            decoration: InputDecoration(hintText: 'Username'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "password can not be empty";
              }
            },
            controller: password,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Sign Up'))
        ]),
      ),
    );
  }
}
