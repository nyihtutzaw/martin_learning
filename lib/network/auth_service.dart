import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

class AuthService {
  static login(data) async {
    try {
      Response response =
          await ApiService.getApiHandler('').post("io-login", data: data);

      return response.data;
    } on DioError catch (e) {
      if (e.response!.statusCode != 200) {
        throw e.response!.data["errors"];
      }
    }
  }

  static register(data) async {
    try {
      Response response =
          await ApiService.getApiHandler('').post("io-register", data: data);
      return response.data;
    } on DioError catch (e) {
      if (e.response!.statusCode != 200) {
        throw e.response!.data["errors"];
      }
    }
  }

  static getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response =
        await ApiService.getApiHandler(storedData['token']).get('user');
    return response.data;
  }
}
