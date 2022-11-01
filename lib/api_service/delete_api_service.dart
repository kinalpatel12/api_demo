import 'dart:convert';

import 'package:http/http.dart' as http;

class DeleteService {
  static Future deleteService({String? userName}) async {
    var reqBody = {"username": userName};
    http.Response response = await http.post(
        Uri.parse(
            "https://codelineinfotech.com/student_api/User/delete_user.php"),
        body: reqBody);

    var result = jsonDecode(response.body);
    print('Delete Response===>>${jsonDecode(response.body)}');
    print("*****************");
    return result;
  }
}
