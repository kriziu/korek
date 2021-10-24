import 'package:enum_to_string/enum_to_string.dart';
import 'package:korek/helpers/subjects.dart';

class RegisterData {
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String userType = "student";
  String avatarId = "female_1";
  double price = 20;
  List<Subjects> subjects = [];
  List connected = [];

  Map<String, dynamic> getJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "price": price,
      "avatarId": avatarId,
      "userType": userType,
      "subjects": subjects.map((e) => EnumToString.convertToString(e)).toList(),
      "connected": connected,
    };
  }
}
