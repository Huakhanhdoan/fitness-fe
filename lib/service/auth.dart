import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

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
Future<User> getUserInfo(String userId) async {
  // Replace with your actual API key


  // Construct the API URL with the provided user ID
  final String apiUrl = 'https://fitness-be.onrender.com/user/$userId';

  // Create an HTTP request using the API URL and headers
  final http.Response response = await http.get(
    Uri.parse(apiUrl),
  );

  // Check the response status code
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    // Map JSON to User object
    User user = User.fromJson(jsonResponse['user']);

    // Print User details

    return user;
  } else {
    // Handle error scenarios (e.g., invalid user ID, network errors)
    throw Exception('Failed to get user information: ${response.statusCode}');
  }
}
