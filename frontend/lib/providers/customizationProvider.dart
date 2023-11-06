import 'package:flutter/material.dart';

class CustomProvider extends ChangeNotifier {
  Color? _corTema;

CustomProvider(Color c){
  _corTema=c;

}
  Color get corTema => _corTema!;

  void mudaCorTema(Color c) {
    _corTema = c;
    notifyListeners(); 
  }
}
