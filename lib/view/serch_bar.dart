import 'dart:io';

import 'package:api_app/api_service/sign_up_with_model.dart';
import 'package:api_app/view/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/sign_up_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstName = TextEditingController();

  final lastName = TextEditingController();

  final userName = TextEditingController();

  final password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final picker = ImagePicker();
  File? image;

  Future getImageFromGallery() async {
    final pickedFIle = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFIle != null) {
      setState(
        () {
          image = File(pickedFIle.path);
        },
      );
    }
  }

  Future getImageFromCamera() async {
    final pickedFIle = await picker.pickImage(source: ImageSource.camera);

    if (pickedFIle != null) {
      setState(
        () {
          image = File(pickedFIle.path);
        },
      );
    }
  }

  Future uploadUserImage({String? fileName}) async {
    dio.FormData formData = dio.FormData.fromMap({
      'avatar':
          await dio.MultipartFile.fromFile(image!.path, filename: fileName)
    });
    dio.Response response = await dio.Dio().post(
        'https://codelineinfotech.com/student_api/User/user_avatar_upload.php',
        data: formData);

    if (response.data['url'] != null) {
      return response.data['url'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    getImageFromCamera();
                                    Navigator.pop(context);
                                  },
                                  color: Colors.teal,
                                  child: Text("Camera"),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    getImageFromGallery();
                                    Navigator.pop(context);
                                  },
                                  color: Colors.teal,
                                  child: Text("Gallery"),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: ClipOval(
                        child: image == null
                            ? Icon(
                                Icons.add_a_photo_outlined,
                                size: 100,
                              )
                            : Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "firstname can not be empty";
                      }
                    },
                    controller: firstName,
                    decoration: InputDecoration(hintText: 'Firstname'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "lastname can not be empty";
                      }
                    },
                    controller: lastName,
                    decoration: InputDecoration(hintText: 'lastname'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "username can not be empty";
                      }
                    },
                    controller: userName,
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
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          final url = await uploadUserImage(
                              fileName: "${userName.text}");

                          signUpModel model = signUpModel();
                          model.firstName = firstName.text;
                          model.lastName = lastName.text;
                          model.username = userName.text;
                          model.password = password.text;
                          model.avatar = url;

                          bool? status =
                              await SignUpWithModel.signUpUser(model.toJson());

                          if (status == true) {
                            setState(() {
                              isLoading = false;
                            });
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('username', userName.text);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  SnackBar(
                                    content: Text('Successfully SignUp'),
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
                                content: Text('SignUp Failed'),
                              ),
                            );
                          }
                          // SignUpUser.signUpUser(
                          //         firstName: firstName.text,
                          //         lastName: lastName.text,
                          //         userName: userName.text,
                          //         passWord: password.text)
                          //     .then(
                          //   (value) => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => HomePage(),
                          //     ),
                          //   ),
                          // );
                        }
                      },
                      child: Text('Sign Up'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
