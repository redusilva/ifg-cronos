import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final double? tamanhoUtilizado;
  final double? espacoTotal;
  final String? labelUtilizado;
  final double? tamanhoTotal;
  final String? labelTotal;
  final double? espacoUtilizado;
  final double? tamanho;

  final String? labelDisponivel;
  const ChartBar({
    this.labelDisponivel,
    this.tamanho,
    this.espacoUtilizado,
    this.tamanhoTotal,
    this.labelTotal,
    this.tamanhoUtilizado,
    this.espacoTotal,
    this.labelUtilizado,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double porcentagem= (espacoUtilizado!/espacoTotal!)*100;
    Color corDaBarra= Colors.green[700]!;
    if(porcentagem>50){
      corDaBarra= Colors.amber[700]!;
    }
    if(porcentagem>90){
      corDaBarra= Colors.red[700]!;
    }
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(
              height: 20,
              child: FittedBox(
                child: Text(
                    "Armazenamento:",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16, // Tamanho da fonte personalizado
                          color: Colors.green[700],
                        )),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.31,
              width: constraints.maxWidth * 0.7,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: espacoUtilizado! / espacoTotal!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: corDaBarra,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           SizedBox(height: constraints.maxHeight*0.07),
            Container(
              height: constraints.maxHeight*0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, // Espaçar os textos para os cantos
                children: [
                  Text("Utilizado: " +
                      NumberFormat('0.0 ').format(tamanhoUtilizado) +
                      labelUtilizado!),
                  Text("Disponível: " +
                      NumberFormat('0.0 ').format(tamanho) +
                      labelDisponivel!),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
