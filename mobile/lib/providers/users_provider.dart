import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:korek/helpers/helpers.dart';
import 'package:korek/helpers/token_manager.dart';
import 'package:korek/models/rating.dart';
import 'package:korek/models/user.dart';

class UsersProvider with ChangeNotifier {
  final List<User> _teachers = [];

  List<User> get teachers => [..._teachers];

  Future<void> fetchTeachers() async {
    _teachers.clear();

    final response = await http.get(Uri.parse('$BASE_URL/users'));
    final jsonData = jsonDecode(response.body) as List<dynamic>;
    final data = jsonData.map((user) => User.fromJson(user));
    data.forEach((user) {
      if (user.userType == 'teacher') {
        _teachers.add(user);
      }
    });
    notifyListeners();
  }


  Future<void> addRate(Rating rating) async {
    final token = await TokenManager.token;
    final response = await http.post(Uri.parse('$BASE_URL/rates'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
        body: jsonEncode(rating.toJson()));
    final jsonData = (jsonDecode(response.body) as Map<String, dynamic>);
    if (jsonData.containsKey('error')) {
      throw Exception(response.body);
    } else {
      await fetchTeachers();
    }
  }

}
