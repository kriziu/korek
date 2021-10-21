
class Message {
  final String roomId;
  final String from;
  String message="";

  Message(this.roomId,this.from,this.message);


  Map<String,dynamic> toJson() => {
      "roomId":roomId,
      "from":from,
      "message":message,
  };

}