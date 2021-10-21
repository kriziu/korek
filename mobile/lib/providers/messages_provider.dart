import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:korek/models/message.dart';
import 'package:korek/models/user.dart';

class MessagesProvider with ChangeNotifier {

  final List<User> _chatted = [];
  List<User> get chatted => [..._chatted];


  Future<void> sendMessage(Message message) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/messages'),
      body: jsonEncode(message.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if ((jsonDecode(response.body) as Map<String, dynamic>)
        .containsKey('error')) {
      throw Exception(jsonDecode(response.body)['error']);
    }
    notifyListeners();
  }


  Future<void> fetchChatted(String id) async {
    try{
      _chatted.clear();
      final response = await http.get(Uri.parse('$BASE_URL/users/chatted/$id'));
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final data = jsonData.map((user) => User.fromJson(user));
      data.forEach((user) {
        _chatted.add(user);
      });
      notifyListeners();
    }catch(e){
      rethrow;
    }
  }
}
