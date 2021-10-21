import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:http/http.dart' as http;

class MessagesProvider with ChangeNotifier{

  Future<void> sendMessage() async {
    final response = await http.post(Uri.parse('$BASE_URL/messages'),body: {
      "roomId":"essa",
      "from":"mojeid",
      "messa":"message",
    });
    final jsonData = jsonDecode(response.body) as List<dynamic>;

    notifyListeners();
    // wysylanie widomosci na czacie
    // post ten wyzej
    // przy wchodzeniu joinRoom
    // emit("send","mess")
  }


}