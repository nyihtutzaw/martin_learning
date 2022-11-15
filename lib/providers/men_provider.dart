import 'package:flutter/material.dart';
import 'package:optimize/models/MenModel.dart';
import 'package:optimize/network/men_service.dart';

class MenProvider with ChangeNotifier {
  bool menLoading = false;
  List<MenModel> mens = [];

  Future<void> getAll() async {
    menLoading = true;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
    mens.clear();
    var response = await MenService.getAll();
    for (int i = 0; i < response["data"].length; i++) {
      mens.add(MenModel(
        id: response["data"][i]["id"],
        title: response["data"][i]["title"] ?? "",
        subtitle: response['data'][i]['subtitle'] ?? "",
        body: response["data"][i]["body"] ?? "",
        image: response["data"][i]["image"] ?? "",
      ));
    }
    menLoading = false;
    notifyListeners();
  }
}
