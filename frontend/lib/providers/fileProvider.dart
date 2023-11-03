import 'package:flutter/material.dart';

class FileProvider extends ChangeNotifier {
  List<dynamic> _arquivos = [];

  List<dynamic>  get arquivos =>  _arquivos;

  void atualizaArquivos(List<dynamic> a) {
    print("fgds");
    _arquivos = a;
    notifyListeners(); 
  }
}
