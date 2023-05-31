import 'package:flutter/material.dart';

class FloatingWindowProvider with ChangeNotifier {
  FloatingWindowProvider();

  Widget? _child;
  Widget? get child => _child;
  set child(Widget? child) {
    _child = child;
    notifyListeners();
  }

  void refresh() {
    final tmp = _child;
    _child = null;
    notifyListeners();
    _child = tmp;
    notifyListeners();
  }
}