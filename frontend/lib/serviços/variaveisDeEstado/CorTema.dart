import 'package:flutter/material.dart';

class CorPrincipal extends ChangeNotifier {
  Color? _corTema;

CorPrincipal(Color c){
  _corTema=c;

}
  Color get corTema => _corTema!;

  void mudaCorTema(Color c) {
    _corTema = c;
    notifyListeners(); 
  }
}
