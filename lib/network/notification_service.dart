import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

class NotiService {
  static bool auth = true;
  static getAll() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response = await ApiService.getApiHandler(storedData['token'])
        .get('notifications');
    return response.data;
  }
}
