import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:optimize/models/BlogModel.dart';
import 'package:optimize/models/Noti.dart';
import 'package:optimize/network/notification_service.dart';

class BlogProvider with ChangeNotifier {
  List<BlogModel> blogs = [];
  bool isExisted = true;
  var imageUrl = 'https://mar-thin.com/wp-json/wp/v2/media';
  Future<void> getAll(int page) async {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://mar-thin.com/wp-json/wp/v2/",
    );
    Dio dio = new Dio(options);
    Response response = await dio.get('posts?page=${page.toString()}');
    var data = response.data;

    for (int k = 0; k < data.length; k++) {
      String image =
          'https://www.elegantthemes.com/blog/wp-content/uploads/2019/04/change-wordpress-thumbnail-size-featured-image.jpg';
      if (data[k]["featured_media"] != 0) {
        Response imageResponse = await dio
            .get(imageUrl + "/" + data[k]["featured_media"].toString());
        var imageData = imageResponse.data;
        image = imageData["source_url"];
      }

      blogs.add(BlogModel(
          id: data[k]["id"],
          title: data[k]["title"]["rendered"],
          content: data[k]["content"]["rendered"],
          image: image));
    }

    if (data.length == 0) {
      isExisted = true;
    }

    notifyListeners();
  }
}
