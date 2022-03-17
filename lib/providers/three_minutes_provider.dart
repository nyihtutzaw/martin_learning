import 'package:flutter/material.dart';
import 'package:optimize/models/PlusOne.dart';
import 'package:optimize/models/ThreeMintues.dart';
import 'package:optimize/network/plus_one_service.dart';
import 'package:optimize/network/three_minutes_service.dart';

class ThreeMinutesProvider with ChangeNotifier {
  List<ThreeMinutes> items = [];
  late ThreeMinutes item;

  Future<void> getAll(bool sorted) async {
    items.clear();
    var response = await ThreeMinutesService.getAll();

    for (var i = 0; i < response["data"].length; i++) {
      ThreeMinutes data = ThreeMinutes(
        id: response["data"][i]["id"],
        title: response["data"][i]["title"],
        code: response["data"][i]["code"],
        subtitle: response["data"][i]["subtitle"],
        description: response["data"][i]["description"] != null
            ? response["data"][i]["description"]
            : "",
        audio: response["data"][i]["audio"] != null
            ? response["data"][i]["audio"]
            : "",
        video: response["data"][i]["video"] != null
            ? response["data"][i]["video"]
            : "",
        isUtube: response["data"][i]["isYoutube"],
        thumbnail: response["data"][i]["thumbnail"] != null
            ? response["data"][i]["thumbnail"]
            : "",
        isBooked: response["data"][i]["isBooked"],
        isLiked: response["data"][i]["isLiked"],
        isTipped: response["data"][i]["isTiped"],
      );
      items.add(data);
    }

    if (sorted) {
      print("hi");
      items = new List.from(items.reversed);
    }

    notifyListeners();
  }

  Future<void> getEach(int id) async {
    var response = await ThreeMinutesService.getEach(id);
    item = ThreeMinutes(
      id: response["data"]["id"],
      title: response["data"]["title"],
      code: response["data"]["code"],
      subtitle: response["data"]["subtitle"],
      description: response["data"]["description"] != null
          ? response["data"]["description"]
          : "",
      audio: response["data"]["audio"] != null ? response["data"]["audio"] : "",
      video: response["data"]["video"] != null ? response["data"]["video"] : "",
      isUtube: response["data"]["isYoutube"],
      thumbnail: response["data"]["thumbnail"] != null
          ? response["data"]["thumbnail"]
          : "",
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
    var response = await ThreeMinutesService.markData(type, id, value);
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
