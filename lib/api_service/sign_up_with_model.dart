import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpWithModel {
  static Future<bool> signUpUser(Map<String, dynamic> reqBody) async {
    http.Response response = await http.post(
        Uri.parse("https://codelineinfotech.com/student_api/User/signup.php"),
        body: reqBody);

    var result = jsonDecode(response.body);
    print('Sign Up Response===>>${jsonDecode(response.body)}');
    print("*****************");
    return result['status'];
  }
}
