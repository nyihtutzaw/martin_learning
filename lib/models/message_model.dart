class MessageModel {
  final String chatId;
  final int senderId;
  final int receiverId;
  final String message;
  final String media;

  MessageModel({
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.media,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      chatId: json['chatId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      media: json['media'],
    );
  }
}
