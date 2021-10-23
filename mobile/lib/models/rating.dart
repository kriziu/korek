class Rating {
  String id = "";
  double rating = 5;
  String rateMessage = "";

  Rating(this.rating, this.rateMessage, {this.id = ""});

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(json['rating'] ?? 0, json['rateMessage'] ?? "",
          id: json['_id'] ?? "");
}
