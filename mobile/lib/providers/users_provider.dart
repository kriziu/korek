// ignore: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:korek/models/user.dart';
import 'package:http/http.dart' as http;

class UsersProvider with ChangeNotifier {
  final List<User> _students = [];
  final List<User> _teachers = [];

  List<User> get students => [..._students];

  List<User> get teachers => [..._teachers];

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.129:8080/users'));

    if (response.statusCode == 200) {
      _students.clear();
      _teachers.clear();
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final data = jsonData.map((user) => User.fromJson(user));
      data.forEach((user) {
        if (user.userType == 'teacher') {
          _teachers.add(user);
        } else {
          _students.add(user);
        }
      });
    } else {}
  }
}
