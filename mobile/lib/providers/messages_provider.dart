import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:korek/helpers/helpers.dart';
import 'package:korek/helpers/token_manager.dart';
import 'package:korek/models/message.dart';
import 'package:korek/models/user.dart';

class MessagesProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => [..._messages];

  List<User> _chatted = [];

  List<User> get chatted => [..._chatted];

  Future<void> sendMessage(Message message) async {
    final token = await TokenManager.token;
    final response = await http.post(
      Uri.parse('$BASE_URL/messages'),
      body: jsonEncode(message.toJson()),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token,
      },
    );
    if ((jsonDecode(response.body) as Map<String, dynamic>)
        .containsKey('error')) {
      throw Exception(jsonDecode(response.body)['error']);
    }

    notifyListeners();
  }

  Future<void> fetchChatted() async {
    final token = await TokenManager.token;
    try {
      _chatted.clear();
      final response =
          await http.get(Uri.parse('$BASE_URL/users/chatted'), headers: {
        HttpHeaders.authorizationHeader: token,
      });
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final data = jsonData.map((user) => User.fromJson(user));
      data.forEach((user) {
        _chatted.add(user);
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchChatMessages(String roomId) async {
    final token = await TokenManager.token;
    try {
      _messages.clear();
      final response =
          await http.get(Uri.parse('$BASE_URL/messages/$roomId'), headers: {
        HttpHeaders.authorizationHeader: token,
      });
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final data = jsonData.map((message) => Message.fromJson(message));
      data.forEach((message) {
        _messages.add(message);
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void receiveMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
  void clearMessages(){
    _messages = [];
    notifyListeners();
  }

  Future<void> deleteChat(String roomId,String userId) async{
      final token = await TokenManager.token;
      final response = await http.delete(
        Uri.parse('$BASE_URL/messages/$roomId'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
      );
      if ((jsonDecode(response.body) as Map<String, dynamic>)
          .containsKey('error')) {
        throw Exception(jsonDecode(response.body)['error']);
      }
      _chatted = _chatted.where((user) => user.id != userId).toList();
      notifyListeners();
  }
}
