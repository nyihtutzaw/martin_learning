import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:optimize/models/BlogModel.dart';
import 'package:optimize/models/Noti.dart';
import 'package:optimize/network/notification_service.dart';

class BlogProvider with ChangeNotifier {
  List<BlogModel> blogs = [];
  var imageUrl = 'https://mar-thin.com/wp-json/wp/v2/media';
  Future<void> getAll(bool sorted) async {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://mar-thin.com/wp-json/wp/v2/",
    );
    Dio dio = new Dio(options);
    Response response = await dio.get('posts');
    var data = response.data;

    for (int k = 0; k < data.length; k++) {
      Response imageResponse =
          await dio.get(imageUrl + "/" + data[k]["featured_media"].toString());
      var imageData = imageResponse.data;
      blogs.add(BlogModel(
          id: data[k]["id"],
          title: data[k]["title"]["rendered"],
          content: data[k]["content"]["rendered"],
          image: imageData["guid"]["rendered"]));
    }

    if (sorted) {
      blogs = new List.from(blogs.reversed);
    }

    notifyListeners();
  }
}
