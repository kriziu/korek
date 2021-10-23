import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:korek/models/register_data.dart';
import 'package:korek/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {

  User? _user;
  User? get user => _user;

  Future<void> registerUser(RegisterData registerData) async {
    final response = await http.post(Uri.parse('$BASE_URL/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registerData.getJson()));
    if ((jsonDecode(response.body) as Map<String, dynamic>)
        .containsKey('error')) {
      throw Exception(jsonDecode(response.body)['error']);
    } else {
      // final token = jsonDecode(response.body);
      //Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      _user = User.fromJson(jsonDecode(response.body));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("id", user!.id);
      notifyListeners();
    }
  }

  Future<void> autoIdLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("id")) {
      final response = await http.get(
        Uri.parse('$BASE_URL/users/${prefs.getString("id")}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final jsonData = (jsonDecode(response.body) as Map<String, dynamic>);
      if (jsonData.containsKey('error') || jsonData.containsKey('message')) {
        throw Exception(response.body);
      } else {
        _user = User.fromJson(jsonDecode(response.body));
        notifyListeners();
      }
    } else {
      _user = null;
      notifyListeners();
    }
  }


  Future<void> logIn(Map<String,dynamic> loginData) async{
    final response = await http.post(Uri.parse('$BASE_URL/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(loginData));
    if ((jsonDecode(response.body) as Map<String, dynamic>).containsKey('error')) {
      throw Exception(jsonDecode(response.body)['error']);
    } else {
      _user = User.fromJson(jsonDecode(response.body));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("id", user!.id);
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("id");
    _user = null;
    notifyListeners();
  }


  Future<void> updateUserInfo(String fieldName, dynamic newValue) async{
      final response = await http.patch(Uri.parse('$BASE_URL/users/${user!.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          fieldName : newValue
        })
      );
      final jsonData = (jsonDecode(response.body) as Map<String, dynamic>);
      if (jsonData.containsKey('error') || jsonData.containsKey('message')) {
        throw Exception(response.body);
      } else {
        _user = User.fromJson(jsonDecode(response.body));
        notifyListeners();
      }
  }
}
