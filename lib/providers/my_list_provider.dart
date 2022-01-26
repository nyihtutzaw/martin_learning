import 'package:flutter/material.dart';
import 'package:optimize/models/Category.dart';
import 'package:optimize/models/OneZOne.dart';
import 'package:optimize/models/PlusOne.dart';
import 'package:optimize/models/Pn.dart';
import 'package:optimize/network/one_z_one_service.dart';
import 'package:optimize/network/plus_one_service.dart';
import 'package:optimize/network/pn_service.dart';

class MyListProvider with ChangeNotifier {
  List<OneZOne> favOneZOnes = [];
  List<Pn> favPns = [];
  List<PlusOne> favPlusOnes = [];

  List<OneZOne> tipOneZOnes = [];
  List<Pn> tipPns = [];
  List<PlusOne> tipPlusOnes = [];

  List<OneZOne> bookOneZOnes = [];
  List<Pn> bookPns = [];
  List<PlusOne> bookPlusOnes = [];

  Future<void> getAll() async {
    favOneZOnes.clear();
    favPns.clear();
    favPlusOnes.clear();
    tipOneZOnes.clear();
    tipPns.clear();
    tipPlusOnes.clear();
    bookOneZOnes.clear();
    bookPns.clear();
    bookPlusOnes.clear();

    // fav
    var response = await OneZOneService.getAllLikes();
    for (var i = 0; i < response["data"].length; i++) {
      OneZOne data = OneZOne(
        id: response["data"][i]["id"],
        title: response["data"][i]["title"],
        video: response["data"][i]["video"] != null
            ? response["data"][i]["video"]
            : "",
        isUtube: response["data"][i]["isYoutube"],
        subtitle: response["data"][i]["subtitle"],
        description: response["data"][i]["description"],
        thumbnail: response["data"][i]["thumbnail"],
        poster_image: response["data"][i]["poster_image"],
        isBooked: response["data"][i]["isBooked"],
        isLiked: response["data"][i]["isLiked"],
        isTipped: response["data"][i]["isTiped"],
        isSub: response["data"][i]["isSubscribed"],
        pdfFiles: [],
        audioFiles: [],
        videoFiles: [],
      );
      favOneZOnes.add(data);
    }

    response = await PlusOneService.getAllLikes();

    for (var i = 0; i < response["data"].length; i++) {
      PlusOne data = PlusOne(
        id: response["data"][i]["id"],
        title: response["data"][i]["title"],
        code: response["data"][i]["code"],
        subtitle: response["data"][i]["subtitle"],
        description: response["data"][i]["description"],
        audio: response["data"][i]["audio"],
        video: response["data"][i]["video"],
        isUtube: response["data"][i]["isYouTube"],
        thumbnail: response["data"][i]["thumbnail"],
        isBooked: response["data"][i]["isBooked"],
        isLiked: response["data"][i]["isLiked"],
        isTipped: response["data"][i]["isTiped"],
      );
      favPlusOnes.add(data);
    }

    response = await PnService.getAllLikes();

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
          coverImage: response["data"][i]["cover_image"],
          introVideo: response["data"][i]["intro_video"],
          introThumbnail: response["data"][i]["intro_video_thumbnail"],
          introDescription: response["data"][i]["intro_description"],
          isBooked: response["data"][i]["isBooked"],
          isLiked: response["data"][i]["isLiked"],
          isTipped: response["data"][i]["isTiped"],
          isSub: response["data"][i]["isSubscribed"],
          pdfFiles: [],
          audioFiles: [],
          videoFiles: [],
          categories: categories);
      favPns.add(data);
    }

    // fav

    // tip
    response = await OneZOneService.getAllTips();
    for (var i = 0; i < response["data"].length; i++) {
      OneZOne data = OneZOne(
        id: response["data"][i]["id"],
        video: response["data"][i]["video"] != null
            ? response["data"][i]["video"]
            : "",
        isUtube: response["data"]["is_youtube"],
        title: response["data"][i]["title"],
        subtitle: response["data"][i]["subtitle"],
        description: response["data"][i]["description"],
        thumbnail: response["data"][i]["thumbnail"],
        poster_image: response["data"][i]["poster_image"],
        isBooked: response["data"][i]["isBooked"],
        isLiked: response["data"][i]["isLiked"],
        isTipped: response["data"][i]["isTiped"],
        isSub: response["data"][i]["isSubscribed"],
        pdfFiles: [],
        audioFiles: [],
        videoFiles: [],
      );
      tipOneZOnes.add(data);
    }

    response = await PlusOneService.getAllTips();

    for (var i = 0; i < response["data"].length; i++) {
      PlusOne data = PlusOne(
        id: response["data"][i]["id"],
        title: response["data"][i]["title"],
        code: response["data"][i]["code"],
        subtitle: response["data"][i]["subtitle"],
        description: response["data"][i]["description"],
        audio: response["data"][i]["audio"],
        video: response["data"][i]["video"],
        thumbnail: response["data"][i]["thumbnail"],
        isBooked: response["data"][i]["isBooked"],
        isUtube: response["data"][i]["isYouTube"],
        isLiked: response["data"][i]["isLiked"],
        isTipped: response["data"][i]["isTiped"],
      );
      tipPlusOnes.add(data);
    }

    response = await PnService.getAllTips();

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
          coverImage: response["data"][i]["cover_image"],
          introVideo: response["data"][i]["intro_video"],
          introThumbnail: response["data"][i]["intro_video_thumbnail"],
          introDescription: response["data"][i]["intro_description"],
          isBooked: response["data"][i]["isBooked"],
          isLiked: response["data"][i]["isLiked"],
          isTipped: response["data"][i]["isTiped"],
          isSub: response["data"][i]["isSubscribed"],
          videoFiles: [],
          pdfFiles: [],
          audioFiles: [],
          categories: categories);
      tipPns.add(data);
    }

    // tip

    // book
    response = await OneZOneService.getAllBooks();
    for (var i = 0; i < response["data"].length; i++) {
      OneZOne data = OneZOne(
        id: response["data"][i]["id"],
        video: response["data"][i]["video"] != null
            ? response["data"][i]["video"]
            : "",
        isUtube: response["data"][i]["isYoutube"],
        title: response["data"][i]["title"],
        subtitle: response["data"][i]["subtitle"],
        description: response["data"][i]["description"],
        thumbnail: response["data"][i]["thumbnail"],
        poster_image: response["data"][i]["poster_image"],
        isBooked: response["data"][i]["isBooked"],
        isLiked: response["data"][i]["isLiked"],
        isTipped: response["data"][i]["isTiped"],
        isSub: response["data"][i]["isSubscribed"],
        pdfFiles: [],
        audioFiles: [],
        videoFiles: [],
      );
      bookOneZOnes.add(data);
    }

    response = await PlusOneService.getAllBooks();

    for (var i = 0; i < response["data"].length; i++) {
      PlusOne data = PlusOne(
        id: response["data"][i]["id"],
        title: response["data"][i]["title"],
        code: response["data"][i]["code"],
        subtitle: response["data"][i]["subtitle"],
        description: response["data"][i]["description"],
        audio: response["data"][i]["audio"],
        video: response["data"][i]["video"],
        isUtube: response["data"][i]["isYouTube"],
        thumbnail: response["data"][i]["thumbnail"],
        isBooked: response["data"][i]["isBooked"],
        isLiked: response["data"][i]["isLiked"],
        isTipped: response["data"][i]["isTiped"],
      );
      bookPlusOnes.add(data);
    }

    response = await PnService.getAllBooks();

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
          coverImage: response["data"][i]["cover_image"],
          introVideo: response["data"][i]["intro_video"],
          introThumbnail: response["data"][i]["intro_video_thumbnail"],
          introDescription: response["data"][i]["intro_description"],
          isBooked: response["data"][i]["isBooked"],
          isLiked: response["data"][i]["isLiked"],
          isTipped: response["data"][i]["isTiped"],
          isSub: response["data"][i]["isSubscribed"],
          pdfFiles: [],
          audioFiles: [],
          videoFiles: [],
          categories: categories);
      bookPns.add(data);
    }

    // book

    notifyListeners();
  }
}
