import 'dart:convert';
import 'package:web_socket_flutter/utils/constants.dart';
import 'package:http/http.dart' as http;

class Services {
  final url = Uri.parse("${Constants.url}student");

  Future<Map<String, dynamic>> deleteData(
    String id,
    String token,
  ) async {
    final response = await http.delete(
      Uri.parse("$url/$id"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    var jsonData = await jsonDecode(response.body);
    return {
      "data": jsonData,
      "status": response.statusCode,
    };
  }

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(url);
    var jsonData = await jsonDecode(response.body);
    return jsonData;
  }

  Future<Map<String, dynamic>> postData(
    String classes,
    String major,
    String firstName,
    String lastName,
    String token,
  ) async {
    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {
        "classes": classes,
        "major": major,
        "fname": firstName,
        "lname": lastName
      },
    );
    var jsonData = await jsonDecode(response.body);
    return {
      "data": jsonData,
      "status": response.statusCode,
    };
  }

  Future<Map<String, dynamic>> postLogin(
    String email,
    String password,
  ) async {
    final response = await http.post(
        Uri.parse(
          "${Constants.url}auth",
        ),
        headers: {
          "Accept": "Application/json"
        },
        body: {
          "email": email,
          "password": password,
        });

    var jsonData = await jsonDecode(response.body);
    return {
      "data": jsonData,
      "status": response.statusCode,
    };
  }
}
