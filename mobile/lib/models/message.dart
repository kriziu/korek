class Message {
  final String roomId;
  final String from;
  String message = "";

  Message(this.roomId, this.from, this.message);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        json['roomId'] ?? '', json['from'] ?? '', json['message'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
        "from": from,
        "message": message,
      };
}
