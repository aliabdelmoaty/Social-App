class MessageModel {
  String? senderId;
  String? receiverId;
  String? chatImage;
  String? dateTime;
  String? message;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.chatImage,
    this.message,
  });
  MessageModel.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    chatImage = json['chatImage'];
    message = json['message'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'dateTime': dateTime,
      'chatImage': chatImage,
      'receiverId': receiverId,
      'message': message
    };
  }
}
