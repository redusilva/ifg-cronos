import 'package:flutter/material.dart';
import '../../../modelos/referênciaArquivo.dart';
import 'package:intl/intl.dart';
import '../../../serviços/APIs/API_Cliente-Servidor.dart';
import 'package:provider/provider.dart';
import '../../../serviços/variaveisDeEstado/CorTema.dart';
import 'package:file_picker/file_picker.dart';


class ListaDeArquivos extends StatelessWidget {
  final List<ReferenciaArquivo> _arquivos;
  final void Function(String) _remover;
  final String _tokenLogin;

  const ListaDeArquivos(this._arquivos, this._tokenLogin, this._remover,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: _arquivos.isEmpty
          ? LayoutBuilder(builder: (ctx, constraits) {
              return Column(
                children: [
                  SizedBox(height: constraits.maxHeight * 0.05),
                  Text(
                    'Nenhum arquivo enviado!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: constraits.maxHeight * 0.05),
                  SizedBox(
                    height: constraits.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemCount: _arquivos.length,
              itemBuilder: (ctx, index) {
                final arquivo = _arquivos[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: Theme(
                      data: Theme.of(context), 
                      child: Icon(arquivo.iconeDoArquivo,
                          color: Provider.of<CorPrincipal>(context).corTema),
                    ),
                    title: Text(
                      arquivo.nomeDoArquivo,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 20, 
                          ),
                    ),
                    subtitle: Text("Modificado em: "+
                      DateFormat('d MMM y').format(arquivo.dataDeModificacao),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: IconButton(
                              icon: const Icon(Icons.download),
                              color: const Color.fromARGB(255, 55, 142, 213), 
                              onPressed: () async {
                                try {
                                  
                                  String? folderPath = await FilePicker.platform
                                      .getDirectoryPath();

                                  if (folderPath != null) {
                                
                                   dynamic resposta= await download(arquivo.idExterno, _tokenLogin,folderPath);   
                                   print(resposta.runtimeType);                                 
                                  }
                                } catch (e) {
                                  print('Erro ao selecionar a pasta: $e');
                                }
                               
                              },
                            )),
                        LayoutBuilder(builder: (ctx, constraits) {
                          return Column(
                            children: [
                              SizedBox(height: constraits.maxHeight * 0.01),
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
                                                    Provider.of<CorPrincipal>(
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
                                                  arquivo.idExterno, _tokenLogin);

                                          if (resposta != null) {
                                            Navigator.of(context).pop();
                                            _remover(arquivo.idInterno);
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
                                                                .of<CorPrincipal>(
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
