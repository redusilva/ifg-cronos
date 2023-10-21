import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: transactions.isEmpty
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
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: Theme(
                      data: Theme.of(context), // Use o tema atual do contexto
                      child: Icon(tr.icon, color: Colors.green),
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
                                        child: const Text('Cancelar'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Feche o diálogo
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Deletar',
                                          style:
                                              TextStyle(color: Colors.red[900]),
                                        ),
                                        onPressed: () {
                                          onRemove(tr.id);
                                          // ...
                                          Navigator.of(context)
                                              .pop(); // Feche o diálogo
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
