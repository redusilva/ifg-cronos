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
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(
                "TOTAL:  " +
                    NumberFormat('0.0 ').format(tamanhoTotal) +
                    labelTotal!,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 16, // Tamanho da fonte personalizado
                      color: Colors.green[700],
                    )),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 30,
          width: 725,
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
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 05),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // Espaçar os textos para os cantos
          children: [
            Text("Utilizado: " +
                NumberFormat('0.0 ').format(tamanhoUtilizado) +
                labelUtilizado!),
            Text("Disponível: " +
                NumberFormat('0.0 ').format(tamanho) +
                labelDisponivel!),
          ],
        ),
      ],
    );
  }
}
