import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import '../conexãoComBack/conexãoComBack.dart';
import 'package:provider/provider.dart';
import '../providers/customizationProvider.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final void Function(String) _onRemove;
  final String _tokenLogin;

  const TransactionList(this._transactions, this._tokenLogin, this._onRemove,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: _transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraits) {
              return Column(
                children: [
                  SizedBox(height: constraits.maxHeight * 0.05),
                  Text(
                    'Nenhuma arquivo enviado!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: constraits.maxHeight * 0.05),
                  SizedBox(
                    height: constraits.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (ctx, index) {
                final tr = _transactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: Theme(
                      data: Theme.of(context), // Use o tema atual do contexto
                      child: Icon(tr.icon,
                          color: Provider.of<CustomProvider>(context).corTema),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 16, // Tamanho da fonte personalizado
                          ),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: IconButton(
                              icon: const Icon(Icons.download),
                              color: Colors.blue, // Cor do ícone de download
                              onPressed: () {
                                // Lógica para lidar com o download aqui
                              },
                            )),
                        LayoutBuilder(builder: (ctx, constraits) {
                          return Column(
                            children: [
                              SizedBox(height: constraits.maxHeight * 0.05),
                            ],
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).colorScheme.error,
                            onPressed: () => {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmação'),
                                    content: const Text(
                                        'Tem certeza de que deseja deletar?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancelar',
                                            style: TextStyle(
                                                color:
                                                    Provider.of<CustomProvider>(
                                                            context)
                                                        .corTema)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Deletar',
                                          style:
                                              TextStyle(color: Colors.red[900]),
                                        ),
                                        onPressed: () async {
                                          dynamic resposta =
                                              await deletaArquivos(
                                                  tr.idExterno, _tokenLogin);

                                          if (resposta != null) {
                                            Navigator.of(context).pop();
                                            _onRemove(tr.id);
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      const Text("Sucesso!!"),
                                                  content: const Text(
                                                      "Arquivo deletado com sucesso!!"),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: Provider
                                                                .of<CustomProvider>(
                                                                    context)
                                                            .corTema,
                                                      ),
                                                      child:
                                                          const Text('Fechar'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
