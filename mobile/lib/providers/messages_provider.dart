import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:korek/models/message.dart';

class MessagesProvider with ChangeNotifier {



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
}
