import 'package:flutter/material.dart';

class LabelButton3 extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tag;

  const LabelButton3(
    this.label,
    this.icon, {
    required this.onPressed,
    this.tag,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 160, // Aumentando a largura
      height: 70, // Mantendo a altura
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide.none, // Removendo a borda
          ),
          elevation: 0,
          foregroundColor: Colors.blueGrey[400],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green, // Cor de fundo verde
                    borderRadius: BorderRadius.circular(12), // Borda arredondada
                  ),
                  padding: EdgeInsets.all(8), // Espaçamento interno
                  child: Icon(
                    icon,
                    color: Colors.white, // Cor do ícone branca
                    size: 25, // Tamanho do ícone reduzido
                  ),
                ),
                SizedBox(width: 10), // Espaçamento entre o ícone e o texto
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13, // Reduzindo o tamanho do texto
                          ),
                    ),
                    if (tag != null)
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        child: Text(
                          tag!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontSize: 10, // Reduzindo o tamanho do texto da tag
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios,color: Colors.green,size: 14,), // Ícone de seta para a direita
          ],
        ),
      ),
    );
  }
}