import 'package:flutter/material.dart';

class Autenticacao extends ChangeNotifier {
  String _email = "";
  String _senha = "";
  String _token = "";

  String get email => _email;
  String get senha => _senha;
  String get token => _token;

  void defineUsuario(String email, String senha, String token) {
    _email = email;
    _senha = senha;
    _token = token;
    notifyListeners();
  }

  void reseta() {
    _email = "";
    _senha = "";
    _token = "";
    notifyListeners();
  }
}