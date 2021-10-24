import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:korek/helpers/token_manager.dart';
import 'package:korek/models/rating.dart';
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
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registerData.getJson()));
    final result = jsonDecode(response.body) as Map<String, dynamic>;
    if (result.containsKey('error')) {
      throw Exception(jsonDecode(response.body)['error']);
    } else {
      final token = result['token'];
      TokenManager.setToken(token);
      Map<String, dynamic> userObj = (JwtDecoder.decode(token))['user'];
      _user = User.fromJson(userObj);
      notifyListeners();
    }
  }

  Future<void> autoIdLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      Map<String, dynamic> userObj = (JwtDecoder.decode(await TokenManager.token))['user'];
      _user = User.fromJson(userObj);
      notifyListeners();
    } else {
      _user = null;
      notifyListeners();
    }
  }

  Future<void> logIn(Map<String, dynamic> loginData) async {
    final response = await http.post(Uri.parse('$BASE_URL/users/login'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        },
        body: jsonEncode(loginData));
    final result = (jsonDecode(response.body) as Map<String, dynamic>);
    if (result.containsKey('error')) {
      throw Exception(jsonDecode(response.body)['error']);
    } else {
      final token = result['token'];
      TokenManager.setToken(token);
      Map<String, dynamic> userObj = (JwtDecoder.decode(token))['user'];
      _user = User.fromJson(userObj);
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    await TokenManager.deleteToken();
    _user = null;
    notifyListeners();
  }

  Future<void> updateUserInfo(String fieldName, dynamic newValue) async {
    final token = await TokenManager.token;
    final response = await http.patch(Uri.parse('$BASE_URL/users'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode({fieldName: newValue}));
    final jsonData = (jsonDecode(response.body) as Map<String, dynamic>);
    if (jsonData.containsKey('error') || jsonData.containsKey('message')) {
      throw Exception(response.body);
    } else {
      final token = jsonData['token'];
      TokenManager.setToken(token);
      Map<String, dynamic> userObj = (JwtDecoder.decode(token))['user'];
      _user = User.fromJson(userObj);
      notifyListeners();
    }
  }

  Future<void> addDeposit(double much) async {
    final token = await TokenManager.token;
    final response = await http.post(Uri.parse('$BASE_URL/wallet/deposit'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode({"much":much}));
    final jsonData = (jsonDecode(response.body) as Map<String, dynamic>);
    if (jsonData.containsKey('error')) {
      throw Exception(response.body);
    } else {
      final token = jsonData['token'];
      TokenManager.setToken(token);
      Map<String, dynamic> userObj = (JwtDecoder.decode(token))['user'];
      _user = User.fromJson(userObj);
      notifyListeners();
    }
  }


  Future<void> withdraw(double much) async {
    final token = await TokenManager.token;
    final response = await http.post(Uri.parse('$BASE_URL/wallet/withdraw'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode({"much":much}));
    final jsonData = (jsonDecode(response.body) as Map<String, dynamic>);
    if (jsonData.containsKey('error')) {
      throw Exception(response.body);
    } else {
      final token = jsonData['token'];
      TokenManager.setToken(token);
      Map<String, dynamic> userObj = (JwtDecoder.decode(token))['user'];
      _user = User.fromJson(userObj);
      notifyListeners();
    }
  }


  Future<void> pay(double much,String teacherId) async {
    final token = await TokenManager.token;
    final response = await http.post(Uri.parse('$BASE_URL/wallet/pay'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode({"much":much,"teacherId":teacherId}));
    final jsonData = (jsonDecode(response.body) as Map<String, dynamic>);
    if (jsonData.containsKey('error')) {
      throw Exception(response.body);
    } else {
      final token = jsonData['token'];
      TokenManager.setToken(token);
      Map<String, dynamic> userObj = (JwtDecoder.decode(token))['user'];
      _user = User.fromJson(userObj);
      notifyListeners();
    }
  }





}
