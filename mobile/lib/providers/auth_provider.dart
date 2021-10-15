import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:korek/models/register_data.dart';
import 'package:korek/models/user.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  User? _user;

  User get user => user;

  Future<void> registerUser(RegisterData registerData) async {
    final response = await http.post(Uri.parse('$BASE_URL/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registerData.getJson()));
    if ((jsonDecode(response.body) as Map<String, dynamic>).containsKey('error')) {
      throw Exception(jsonDecode(response.body)['error']);
    } else {
      print(jsonDecode(response.body));
    }
  }
}
