import 'package:flutter/material.dart';

class OperationProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _allOperations = [];

  List<Map<String, dynamic>> get allOperations => _allOperations;

  void addOperation(Map<String, dynamic> data) {
    _allOperations.add(data);
    notifyListeners();
  }

  void setOperations(List<Map<String, dynamic>> data) {
    _allOperations.clear();
    _allOperations.addAll(data);
    notifyListeners();
  }
}
