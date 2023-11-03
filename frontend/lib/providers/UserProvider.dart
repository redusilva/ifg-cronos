import 'package:flutter/material.dart';

class EmailProvider extends ChangeNotifier {
  String _email = "";

  String get email => _email;

  void defineUsuario(String email) {
    _email = email;
    notifyListeners();
  }

  void reseta() {
    _email = "";
    notifyListeners();
  }
}
