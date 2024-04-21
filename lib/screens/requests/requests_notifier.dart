import 'package:actuarion/data/request.dart';
import 'package:flutter/material.dart';

class RequestsNotifier with ChangeNotifier {
  final List<Request> requests = [];

  void addRequest(Request request) {
    requests.add(request);
    notifyListeners();
  }

  void removeRequest(Request request) {
    requests.remove(request);
    notifyListeners();
  }
}
