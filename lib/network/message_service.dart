import 'package:dio/dio.dart';
import 'package:optimize/network/chat_api_service.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MessageService {
  static Future<Response?> list(String chatId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('userToken');
      final storedData = json.decode(token!);

      Response response =
          await ChatApiService.getApiHandler(storedData['token'])
              .get('messages/user/$chatId');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  static Future<Response?> create(FormData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('userToken');
      final storedData = json.decode(token!);

      Response response = await ChatApiService.getApiHandler(
              storedData['token'],
              isFormData: true)
          .post('messages/fileupload', data: data);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
