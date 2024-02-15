import 'package:flutter/material.dart';

class LabelButton2 extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  const LabelButton2(
    this.label,
    this.icon, {
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 170, // Aumentando a largura
      height: 70, // Mantendo a altura
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.green, width: 2.0),
          ),
          elevation: 0,
          foregroundColor: Colors.blueGrey[400],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(width: 15,height: 15,),
            Icon(
              icon,
              color: Colors.green,
              size: 30, // Tamanho do ícone
              opticalSize: 30,
            ),
            SizedBox(width: 15), // Espaçamento entre o ícone e o texto
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                      ),
                ),
              
              ],
            ),
          ],
        ),
      ),
    );
  }
}