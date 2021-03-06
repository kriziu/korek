import 'package:enum_to_string/enum_to_string.dart';
import 'package:korek/helpers/subjects.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  double price;
  double rate;
  int wallet;
  String avatarId;
  List<Subjects?> subjects;
  String userType;
  List connected;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.price,
      required this.avatarId,
      required this.subjects,
      required this.rate,
      required this.wallet,
      required this.userType,
      required this.connected});

  String get subjectsStr {
    if (subjects.length == 1) {
      return EnumToString.convertToString(subjects[0], camelCase: true);
    }
    return subjects
        .map(
            (subject) => EnumToString.convertToString(subject, camelCase: true))
        .toList()
        .join(", ");
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['firstName'] ?? 'First Name',
        lastName: json['lastName'] ?? 'Last Name',
        userType: json['userType'] ?? 'student',
        connected: json['connected'] ?? [],
        rate: double.tryParse(json['rate'].toString()) ?? 0,
        wallet: json['wallet'] ?? 36,
        email: json['email'] ?? 'unknown email',
        subjects: (json['subjects'] as List<dynamic>)
            .map((subject) => EnumToString.fromString(subjectsList, subject))
            .toList(),
        price: double.tryParse(json['price'].toString()) ?? 20,
        id: json['_id'] ?? 'unknown id',
        avatarId: json['avatarId'] ?? 'unknown avatar id');
  }

@override
String toString() {
  return firstName+'\n'+lastName+'\n'+userType+'\n'+connected.toString()+'\n'+email+'\n'+subjects.toString()+'\n'+price.toString()+'\n'+id+'\n'+avatarId+'\n';
}

}
