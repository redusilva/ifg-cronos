import 'package:flutter/material.dart';

class LabelButton4 extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const LabelButton4(
    this.label, {
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 110,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.green, // Definindo a cor verde para o container
        borderRadius: BorderRadius.circular(180), // Adicionando borda arredondada
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent, // Definindo cor transparente para o botão
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(180),
            side: BorderSide.none,
          ),
          elevation: 0,
          primary: Colors.transparent, // Definindo cor transparente para o botão
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16), // Definindo a cor branca para o texto
            ),
            
          ],
        ),
      ),
    );
  }
}