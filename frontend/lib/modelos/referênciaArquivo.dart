

import 'package:flutter/material.dart';
class ReferenciaArquivo {
  final String idInterno;
  final String idExterno;
  final String nomeDoArquivo;
  final double tamanhoEmBytes;
  final DateTime dataDeModificacao;
  final IconData iconeDoArquivo;

 const ReferenciaArquivo({
    required this.idInterno,
    required this.idExterno,
    required this.tamanhoEmBytes,
    required this.nomeDoArquivo,
    required this.dataDeModificacao,
    required this.iconeDoArquivo,
  });
}
