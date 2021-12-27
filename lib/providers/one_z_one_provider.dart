import 'package:flutter/material.dart';
import 'package:optimize/models/OneZOne.dart';
import 'package:optimize/models/PlusOne.dart';
import 'package:optimize/network/one_z_one_service.dart';
import 'package:optimize/network/plus_one_service.dart';
import 'package:optimize/network/pn_service.dart';

class OneZOneProvider with ChangeNotifier {
  List<OneZOne> items = [];
  late OneZOne item;

  Future<void> getAll() async {
    items.clear();
    var response = await OneZOneService.getAll();

    for (var i = 0; i < response["data"].length; i++) {
      OneZOne data = OneZOne(
        id: response["data"][i]["id"],
        title: response["data"][i]["title"],
        subtitle: response["data"][i]["subtitle"],
        description: response["data"][i]["description"],
        audio: response["data"][i]["audio"],
        video: response["data"][i]["video"],
        thumbnail: response["data"][i]["thumbnail"],
        poster_image: response["data"][i]["poster_image"],
        workbook: response["data"][i]["workbook"],
        isBooked: response["data"][i]["isBooked"],
        isLiked: response["data"][i]["isLiked"],
        isTipped: response["data"][i]["isTiped"],
      );
      items.add(data);
    }

    notifyListeners();
  }

  Future<void> getEach(int id) async {
    var response = await OneZOneService.getEach(id);
    item = OneZOne(
      id: response["data"]["id"],
      title: response["data"]["title"],
      subtitle: response["data"]["subtitle"],
      description: response["data"]["description"],
      audio: response["data"]["audio"],
      video: response["data"]["video"],
      thumbnail: response["data"]["thumbnail"],
      poster_image: response["data"]["poster_image"],
      workbook: response["data"]["workbook"],
      isBooked: response["data"]["isBooked"],
      isLiked: response["data"]["isLiked"],
      isTipped: response["data"]["isTiped"],
    );
    // for detail screen when it reached from my list
    if (items.length == 0) {
      items.add(item);
    }
    notifyListeners();
  }

  Future<void> markData(String type, int id, int value) async {
    var response = await OneZOneService.markData(type, id, value);
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
