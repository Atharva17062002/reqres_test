import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://reqres.in/api';

  Future<dynamic> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users?page=2'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data'];
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<dynamic> createUser(String name, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: jsonEncode({'name': name, 'email': email}),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      Fluttertoast.showToast(
        msg: 'New user created!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
      );
      return jsonData;
    } else {
      throw Exception('Failed to create user');
    }
  }
}
