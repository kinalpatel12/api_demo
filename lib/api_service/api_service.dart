import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class ApiServices {
  static Future getData() async {
    http.Response response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    var result = jsonDecode(response.body);
    print('Response===>>${jsonDecode(response.body)}');
    return result;
  }

  static List? productList;
  static Future<List<ProductModel>> getWithModel() async {
    http.Response response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );
    var result = jsonDecode(response.body);
    productList = result;
    return productModelFromJson(response.body);
  }
}
