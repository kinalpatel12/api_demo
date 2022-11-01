import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/all_user.dart';

class AllUserData {
  static Future<AllUserModel?> getAllUser() async {
    http.Response response = await http.get(
      Uri.parse('https://codelineinfotech.com/student_api/User/allusers.php'),
    );
    print('Status Code===>>${response.body}');

    if (response.statusCode == 200) {
      return allUserModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
