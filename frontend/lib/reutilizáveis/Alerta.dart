import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../serviços/variaveisDeEstado/CorTema.dart';

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
                backgroundColor:  Provider.of<CorPrincipal>(context)
                    .corTema,
              ),
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            
            
            
          ],
        );
      },
    );
    
  }
}
