import 'package:flutter/material.dart';

class CustomProvider extends ChangeNotifier {
  Color _corTema = Colors.green;

  Color get corTema => _corTema;

  void mudaCorTema(Color c) {
    _corTema = c;
    notifyListeners(); 
  }
}
