class User {
  final String firstName;
  final String secondName;
  final String userType;

  User(
      {required this.firstName,
      required this.secondName,
      required this.userType});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['firstName'] ?? 'First Name',
        secondName: json['secondName'] ?? 'Second Name',
        userType: json['userType'] ?? 'student');
  }
}
