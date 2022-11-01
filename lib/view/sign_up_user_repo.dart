import 'dart:convert';

import 'package:http/http.dart' as http;

class SignUpUser {
  static Future signUpUser({
    String? firstName,
    String? lastName,
    String? userName,
    String? passWord,
  }) async {
    Map reqBody = {
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
      'password': passWord,
      'avatar':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80'
    };
    http.Response response = await http.post(
        Uri.parse('https://codelineinfotech.com/student_api/User/signup.php'),
        body: reqBody); //get ma body option na aavee

    var result = jsonDecode(response.body);
    print('Sign Up Response==>>${jsonDecode(response.body)}');
    return result;
  }
}
