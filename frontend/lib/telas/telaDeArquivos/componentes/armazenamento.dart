import 'package:flutter/material.dart';
import '../../../modelos/referênciaArquivo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../serviços/variaveisDeEstado/CorTema.dart';
import '../../../utilidades/mapeamentoDeArmazenamento.dart';

class MontaBarraDeArmazenamento extends StatelessWidget {
  final List<ReferenciaArquivo> _arquivos;
  final double _espacoTotal;

  const MontaBarraDeArmazenamento(this._arquivos, this._espacoTotal, {Key? key})
      : super(key: key);

  double _calculaEspacoUtilizado() {
    double espacoUtilizado = 0.0;

    for (var arquivo in _arquivos) {
      espacoUtilizado += arquivo.tamanhoEmBytes;
    }

    return espacoUtilizado;
  }

  @override
  Widget build(BuildContext context) {
    final espacoUtilizado = _calculaEspacoUtilizado();
    Map<String, dynamic> formatacaoDoEspacoUsado =
        formataMetrica(espacoUtilizado);
    Map<String, dynamic> formatacaoDoEspacoTotal = formataMetrica(_espacoTotal);
    Map<String, dynamic> formatacaoEspacoDisponivel =
        formataMetrica(_espacoTotal - espacoUtilizado);

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: BarraDeArmazenamentoDinamica(
                tamanhoTotal: formatacaoDoEspacoTotal['tamanho'],
                labelTotal: formatacaoDoEspacoTotal['label'],
                tamanhoUtilizado: formatacaoDoEspacoUsado['tamanho'],
                labelUtilizado: formatacaoDoEspacoUsado['label'],
                espacoTotal: _espacoTotal,
                espacoUtilizado: espacoUtilizado,
                tamanho: formatacaoEspacoDisponivel['tamanho'],
                labelDisponivel: formatacaoEspacoDisponivel['label'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarraDeArmazenamentoDinamica extends StatelessWidget {
  final double? tamanhoUtilizado;
  final double? espacoTotal;
  final String? labelUtilizado;
  final double? tamanhoTotal;
  final String? labelTotal;
  final double? espacoUtilizado;
  final double? tamanho;
  final String? labelDisponivel;

  const BarraDeArmazenamentoDinamica({
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
    final double porcentagem = (espacoUtilizado! / espacoTotal!) * 100;
    Color corDaBarra = Colors.green[900]!;
    if (porcentagem > 50) {
      corDaBarra = Colors.amber[900]!;
    }
    if (porcentagem > 90) {
      corDaBarra = Colors.red[900]!;
    }
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(
              height: 20,
              child: FittedBox(
                child: Text("Armazenamento:",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: Provider.of<CorPrincipal>(context).corTema,
                        )),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.0),
            SizedBox(
              height: constraints.maxHeight * 0.31,
              width: constraints.maxWidth * 0.7,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: corDaBarra,
                        width: 2.5,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: espacoUtilizado! / espacoTotal!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: corDaBarra,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.01),
            Container(
              height: constraints.maxHeight * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
