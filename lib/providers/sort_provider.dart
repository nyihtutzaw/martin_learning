import 'package:flutter/material.dart';

class SortProvider with ChangeNotifier {
  bool sort = true;

  void changeSort() {
    sort = !sort;
    notifyListeners();
  }
}
