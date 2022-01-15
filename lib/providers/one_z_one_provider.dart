import 'package:flutter/material.dart';
import 'package:optimize/models/AudioFile.dart';
import 'package:optimize/models/OneZOne.dart';
import 'package:optimize/models/PdfFile.dart';
import 'package:optimize/models/PlusOne.dart';
import 'package:optimize/models/VideoFile.dart';
import 'package:optimize/network/one_z_one_service.dart';
import 'package:optimize/network/plus_one_service.dart';
import 'package:optimize/network/pn_service.dart';

class OneZOneProvider with ChangeNotifier {
  List<OneZOne> items = [];
  late OneZOne item;

  Future<void> getAll(bool sorted) async {
    items.clear();
    var response = await OneZOneService.getAll();

    for (var i = 0; i < response["data"].length; i++) {
      OneZOne data = OneZOne(
        id: response["data"][i]["id"],
        title: response["data"][i]["title"],
        subtitle: response["data"][i]["subtitle"] != null
            ? response["data"][i]["subtitle"]
            : "",
        description: response["data"][i]["description"] != null
            ? response["data"][i]["description"]
            : "",
        thumbnail: response["data"][i]["thumbnail"] != null
            ? response["data"][i]["thumbnail"]
            : "",
        poster_image: response["data"][i]["poster_image"] != null
            ? response["data"][i]["poster_image"]
            : "",
        isBooked: response["data"][i]["isBooked"],
        isLiked: response["data"][i]["isLiked"],
        isTipped: response["data"][i]["isTiped"],
        isSub: response["data"][i]["isSubscribed"],
        pdfFiles: [],
        audioFiles: [],
        videoFiles: [],
      );
      items.add(data);
    }

    if (sorted) {
      items = new List.from(items.reversed);
    }

    notifyListeners();
  }

  Future<void> getEach(int id) async {
    var response = await OneZOneService.getEach(id);
    List<PdfFile> pdfFiles = [];
    for (var y = 0; y < response["data"]["workbooks"].length; y++) {
      pdfFiles.add(PdfFile(
          id: response["data"]["workbooks"][y]["id"],
          name: response["data"]["workbooks"][y]["title"],
          url: response["data"]["workbooks"][y]["work_book"]));
    }

    List<AudioFile> audioFiles = [];
    for (var y = 0; y < response["data"]["audios"].length; y++) {
      audioFiles.add(AudioFile(
          id: response["data"]["audios"][y]["id"],
          name: response["data"]["audios"][y]["title"],
          url: response["data"]["audios"][y]["audio"]));
    }

    List<VideoFile> videoFiles = [];
    for (var y = 0; y < response["data"]["videos"].length; y++) {
      videoFiles.add(VideoFile(
          id: response["data"]["videos"][y]["id"],
          name: response["data"]["videos"][y]["title"],
          thumbnail: response["data"]["videos"][y]["thumbnail"],
          url: response["data"]["videos"][y]["video"]));
    }

    item = OneZOne(
      id: response["data"]["id"],
      title: response["data"]["title"],
      subtitle: response["data"]["subtitle"],
      description: response["data"]["description"] != null
          ? response["data"]["description"]
          : "",
      thumbnail: response["data"]["thumbnail"] != null
          ? response["data"]["thumbnail"]
          : "",
      poster_image: response["data"]["poster_image"] != null
          ? response["data"]["poster_image"]
          : "",
      isBooked: response["data"]["isBooked"],
      isLiked: response["data"]["isLiked"],
      isTipped: response["data"]["isTiped"],
      isSub: response["data"]["isSubscribed"],
      pdfFiles: pdfFiles,
      audioFiles: audioFiles,
      videoFiles: videoFiles,
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

  Future<void> subscribeCourse(int id) async {
    var response = await OneZOneService.subscribeCourse(id);
    print(response);
  }
}
