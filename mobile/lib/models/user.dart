class User {
  final String firstName;
  final String lastName;
  final String userType;

  User(
      {required this.firstName,
      required this.lastName,
      required this.userType});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['firstName'] ?? 'First Name',
        lastName: json['lastName'] ?? 'Last Name',
        userType: json['userType'] ?? 'student');
  }
}
