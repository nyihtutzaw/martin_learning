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
      favPns.add(data);
    }

    // fav

    // tip
    response = await OneZOneService.getAllTips();
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
      tipPns.add(data);
    }

    // tip

    // book
    response = await OneZOneService.getAllBooks();
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
      bookPns.add(data);
    }

    // book

    notifyListeners();
  }
}