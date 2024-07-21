import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class IdeaService {
  static bool auth = true;

  static getAll() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response = await ApiService.getApiHandler(storedData['token'])
        .get('ideas');
    return response.data;
  }

  static getEach(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response = await ApiService.getApiHandler(storedData['token'])
        .get('ideas/$id');
    return response.data;
  }

  static getAllF() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response = await ApiService.getApiHandler(storedData['token'])
        .get('ideas-featured');
    return response.data;
  }

  static markData(String type, int id, int value) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response = await ApiService.getApiHandler(storedData['token'])
        .post('mark-ideas/$id', data: {type: value});
    return response.data;
  }

  static subscribeCourse() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response = await ApiService.getApiHandler(storedData['token'])
        .get('idea-subscription');
    return response.data;
  }

  static getAllLikes() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response = await ApiService.getApiHandler(storedData['token'])
        .get('idea-likes');
    return response.data;
  }

  static getAllTips() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response = await ApiService.getApiHandler(storedData['token'])
        .get('idea-tips');
    return response.data;
  }

  static getAllBooks() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    final storedData = json.decode(token!);

    Response response = await ApiService.getApiHandler(storedData['token'])
        .get('idea-bookmarks');
    return response.data;
  }
}
