import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:optimize/network/chat_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

class AuthService {
  static login(data) async {
    try {
      Response response =
          await ApiService.getApiHandler('').post("io-login", data: data);

      response.data["register_id"] = data["register_id"];

      return response.data;
    } on DioError catch (e) {
      if (e.response!.statusCode != 200) {
        throw e.response!.data["errors"];
      }
    }
  }

  static Future<Response?> register(data) async {
    try {
      Response response =
          await ApiService.getApiHandler('').post("io-register", data: data);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  static getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response =
        await ApiService.getApiHandler(storedData['token']).get('user');
    String? fireBaseToken = await FirebaseMessaging.instance.getToken();
    response.data["data"]["register_id"] = fireBaseToken;
    await ChatApiService.getApiHandler('')
        .post("user/saveFCM", data: response.data["data"]);
    return response.data;
  }

  static updateInfo(Map<String, String> _authData) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);
    try {
      Response response = await ApiService.getApiHandler(storedData['token'])
          .put("user", data: _authData);
      return response.data;
    } on DioError catch (e) {
      throw e.response!.data.toString();
    }
  }

  static updatePassword(Map<String, String> _authData) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);
    try {
      Response response = await ApiService.getApiHandler(storedData['token'])
          .post("io-change-password", data: _authData);
      return response.data;
    } on DioError catch (e) {
      throw e.response!.data.toString();
    }
  }

  static getUserSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);
    try {
      Response response = await ApiService.getApiHandler(storedData['token'])
          .get("user-subscriptions");
      return response.data;
    } on DioError catch (e) {
      throw e.response!.data.toString();
    }
  }
}
