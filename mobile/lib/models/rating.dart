import 'package:korek/models/user.dart';

class Rating {
  String teacherId = "";
  int stars = 5;
  String message = "";
  User? from;

  Rating(this.stars, this.message, this.teacherId,{this.from});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
      (int.tryParse(json['stars'].toString())) ?? 3,
      json['message'] ?? "",
      json['teacherId'] ?? "",
      from : User.fromJson(json['from']));

  Map<String,dynamic> toJson(){
    return {
        "teacherId": teacherId,
        "stars": stars,
        "message": message,
    };
  }
}
