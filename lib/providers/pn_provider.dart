import 'package:flutter/material.dart';
import 'package:optimize/models/Category.dart';

import 'package:optimize/models/Pn.dart';
import 'package:optimize/network/pn_service.dart';

class PnProvider with ChangeNotifier {
  List<Pn> items = [];
  late Pn item;

  Future<void> getAll() async {
    items.clear();
    var response = await PnService.getAll();

    for (var i = 0; i < response["data"].length; i++) {
      List<Category> categories = [];
      for (var y = 0; y < response["data"][i]["categories"].length; y++) {
        categories.add(Category(
            id: response["data"][i]["categories"][y]["id"],
            name: response["data"][i]["categories"][y]["name"]));
      }
      Pn data = Pn(
          id: response["data"][i]["id"],
          title: response["data"][i]["title"],
          authorName: response["data"][i]["author_name"],
          subtitle: response["data"][i]["subtitle"],
          description: response["data"][i]["description"],
          audio: response["data"][i]["audio"],
          video: response["data"][i]["watch"],
          pdf: response["data"][i]["pdf"],
          coverImage: response["data"][i]["cover_image"],
          introVideo: response["data"][i]["intro_video"],
          introThumbnail: response["data"][i]["intro_video_thumbnail"],
          introDescription: response["data"][i]["intro_description"],
          isBooked: response["data"][i]["isBooked"],
          isLiked: response["data"][i]["isLiked"],
          isTipped: response["data"][i]["isTiped"],
          categories: categories);
      items.add(data);
    }

    notifyListeners();
  }

  Future<void> getEach(int id) async {
    var response = await PnService.getEach(id);
    List<Category> categories = [];
    for (var y = 0; y < response["data"]["categories"].length; y++) {
      categories.add(Category(
          id: response["data"]["categories"][y]["id"],
          name: response["data"]["categories"][y]["name"]));
    }
    item = Pn(
        id: response["data"]["id"],
        title: response["data"]["title"],
        authorName: response["data"]["author_name"],
        subtitle: response["data"]["subtitle"],
        description: response["data"]["description"],
        audio: response["data"]["audio"],
        video: response["data"]["watch"],
        pdf: response["data"]["pdf"],
        coverImage: response["data"]["cover_image"],
        introVideo: response["data"]["intro_video"],
        introThumbnail: response["data"]["intro_video_thumbnail"],
        introDescription: response["data"]["intro_description"],
        isBooked: response["data"]["isBooked"],
        isLiked: response["data"]["isLiked"],
        isTipped: response["data"]["isTiped"],
        categories: categories);

    // for detail screen when it reached from my list
    if (items.length == 0) {
      items.add(item);
    }

    notifyListeners();
  }

  Future<void> markData(String type, int id, int value) async {
    var response = await PnService.markData(type, id, value);
    item = items.firstWhere((element) => element.id == id);

    if (type == "like") {
      item.isLiked = value == 1 ? true : false;
    } else if (type == "bookmark") {
      item.isBooked = value == 1 ? true : false;
    } else if (type == "tip") {
      item.isTipped = value == 1 ? true : false;
    }

    notifyListeners();
  }
}
