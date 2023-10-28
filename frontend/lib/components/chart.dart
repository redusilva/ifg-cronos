import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transations;
  double _espacoTotal;

  Chart(this._transations, this._espacoTotal, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(1, (index) {
      double totalSum = 0.0;
      for (var i = 0; i < _transations.length; i++) {
        totalSum += _transations[i].value;
      }

      return {
        'value': totalSum,
      };
    });
  }

  double get _espacoDoPlano {
    return _espacoTotal;
  }

  Map<String, dynamic> _formataMetrica(double tamanho) {
    final metricas = [
      "B",
      "KB",
      "MB",
      "GB",
      "TB"
    ]; // Adicione mais métricas conforme necessário
    int index = 0;

    while (tamanho >= 1024 && index < metricas.length - 1) {
      tamanho /= 1024;
      index++;
    }

    return {
      'label': metricas[index],
      'tamanho': tamanho,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactions.map((tr) {
            Map<String, dynamic> labelsUsado =
                _formataMetrica(tr['value'] as double);
            Map<String, dynamic> labelsTotal = _formataMetrica(_espacoDoPlano);
            Map<String, dynamic> labelDisponivel =
                _formataMetrica(_espacoDoPlano - (tr['value'] as double));
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tamanhoTotal: labelsTotal['tamanho'],
                labelTotal: labelsTotal['label'],
                tamanhoUtilizado: labelsUsado['tamanho'],
                labelUtilizado: labelsUsado['label'],
                espacoTotal: _espacoDoPlano,
                espacoUtilizado: tr['value'] as double,
                tamanho: labelDisponivel['tamanho'],
                labelDisponivel: labelDisponivel['label'],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
