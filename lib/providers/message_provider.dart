import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../network/message_service.dart';

class MessageProvider with ChangeNotifier {
  String? errorMessage;
  List<MessageModel> messages = [];
  String? fileName;

  static MessageModel _getObject(Map<String, dynamic> data) {
    return MessageModel(
      chatId: data['chatId'],
      senderId: data['senderId'],
      receiverId: data['receiverId'],
      message: data['message'],
      media: data['media'],
    );
  }

  Future<void> list(String chatId) async {
    Response? result = await MessageService.list(chatId);
    if (result!.statusCode == 200) {
      errorMessage = null;
      List<MessageModel> messageList = [];
      var data = result.data['data'];

      if (data.isNotEmpty) {
        for (Map<String, dynamic> element in data) {
          messageList.add(_getObject(element));
        }
      }
      messages = messageList;
    } else if (result.statusCode == 401) {
      errorMessage = result.data['message'];
    } else {
      errorMessage = 'Something was wrong!';
    }
    notifyListeners();
  }

  Future<void> create(FormData data) async {
    Response? result = await MessageService.create(data);
    if (result!.statusCode == 201) {
      errorMessage = null;
      var data = result.data['data'];

      fileName = data;
    } else if (result.statusCode == 401) {
      errorMessage = result.data['message'];
    } else {
      errorMessage = 'Something was wrong!';
    }
    notifyListeners();
  }
}
