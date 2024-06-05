import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<String?> login(String email, String password) async {
  final url = Uri.parse('https://fitness-be.onrender.com/auth/login');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Đăng nhập thành công, trả về token
    final responseData = jsonDecode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id',responseData['user']['_id'] ) ;

    return responseData['token'];

  } else {
    // Đăng nhập thất bại
    throw Exception('Failed to login');
  }
}
Future<String?> register(String name, String email, String password, String phone, String location) async {
  final url = Uri.parse('https://fitness-be.onrender.com/auth/register');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'location': location,
    }),
  );

  if (response.statusCode == 200) {

    final responseData = jsonDecode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id',responseData['user']['_id'] ) ;
    return responseData['token'];
  } else {
    throw Exception('Failed to register');
  }
}