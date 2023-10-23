import 'package:flutter/material.dart';

class Alerta {
  Alerta(BuildContext context, String textoMaior, String textoMenor) {
    _mostrarAlerta(context, textoMaior, textoMenor);
  }

  void _mostrarAlerta(
      BuildContext context, String textoMaior, String textoMenor) {
    showDialog(
      
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(textoMaior),
          content: Text(textoMenor),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o alerta
              },
            ),
            
            
            
          ],
        );
      },
    );
    
  }
}
