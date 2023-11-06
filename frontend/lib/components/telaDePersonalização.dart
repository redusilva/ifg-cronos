import 'package:expenses/providers/customizationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/UserProvider.dart';
import "dart:convert";

import 'package:shared_preferences/shared_preferences.dart';

class PopupMenuButtonWidget extends StatefulWidget {
  @override
  _PopupMenuButtonWidgetState createState() => _PopupMenuButtonWidgetState();
}

class _PopupMenuButtonWidgetState extends State<PopupMenuButtonWidget> {
  Future<void> _armazenaACor(Color color) async {
    int valorARGB = color.value; // Obtém o valor ARGB da cor
    String valorHexadecimal =
        '#${valorARGB.toRadixString(16)}'; // Converte para hexadecimal
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("corPrincipal", json.encode(valorHexadecimal));
  }

  GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<CustomProvider>(context).corTema,
        title: Text(
          'Minha Conta',
          style: TextStyle(
            fontSize: 20 * MediaQuery.of(context).textScaleFactor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Modifique o ícone aqui
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirmação"),
                  content: const Text("Deseja sair?"),
                  actions: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Provider.of<CustomProvider>(context).corTema,
                      ),
                      child: const Text('Não'),
                      onPressed: () {
                        Navigator.of(context).pop(false); // Fecha o alerta
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                      ),
                      child: const Text('Sim'),
                      onPressed: () {
                        Navigator.of(context).pop(true); // Fecha o alerta
                      },
                    )
                  ],
                );
              },
            ).then((value) => {
                  if (value != null)
                    {
                      if (value) {Navigator.of(context).pop()}
                    }
                });
          },
        ),
        //  actions: [
        //   IconButton(
        //      icon: const Icon(Icons.account_circle),
        //        onPressed: () => {_scaffoldKey.currentState!.openEndDrawer()})
        //  ],
      ),
      body: Builder(
        builder: (context) =>
            Consumer<EmailProvider>(builder: (context, provider, child) {
          return Center(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(provider.email.split("@").first),
                  accountEmail: Row(
                    children: [
                      Text(provider.email),
                    ],
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      provider.email[0].toUpperCase(),
                      style: const TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                Column(
                  children: [
                    ListTile(
                      title: const Text('Item 1'),
                      onTap: () {
                        // Ação quando o Item 1 é selecionado
                      },
                    ),
                    ListTile(
                      title: const Text('Item 2'),
                      onTap: () {
                        // Ação quando o Item 2 é selecionado
                      },
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Row(
                              children: [
                                Text(
                                  "Cor tema: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Provider.of<CustomProvider>(context)
                                              .corTema),
                                ),
                                Center(
                                  child: Builder(
                                    builder: (context) =>
                                        Consumer<CustomProvider>(builder:
                                            (context, provider, child) {
                                      return IconButton(
                                        icon: Icon(Icons.border_color,
                                            color: provider.corTema),
                                        onPressed: () {
                                          final RenderBox button = context
                                              .findRenderObject() as RenderBox;
                                          final RenderBox overlay =
                                              Overlay.of(context)
                                                      .context
                                                      .findRenderObject()
                                                  as RenderBox;
                                          final RelativeRect position =
                                              RelativeRect.fromRect(
                                            Rect.fromPoints(
                                              button.localToGlobal(Offset.zero,
                                                  ancestor: overlay),
                                              button.localToGlobal(
                                                  button.size
                                                      .bottomRight(Offset.zero),
                                                  ancestor: overlay),
                                            ),
                                            Offset.zero & overlay.size,
                                          );

                                          showMenu(
                                            context: context,
                                            position: position,
                                            items: <PopupMenuEntry<String>>[
                                              PopupMenuItem<String>(
                                                  value: 'Opção 1',
                                                  child: const Icon(
                                                      Icons.border_color,
                                                      color: Colors.green),
                                                  onTap: () =>
                                                      provider.mudaCorTema(
                                                          Colors.green)),
                                              PopupMenuItem<String>(
                                                  value: 'Opção 2',
                                                  child: const Icon(
                                                      Icons.border_color,
                                                      color: Colors.amber),
                                                  onTap: () =>
                                                      provider.mudaCorTema(
                                                          Colors.amber)),
                                              PopupMenuItem<String>(
                                                value: 'Opção 3',
                                                child: const Icon(
                                                    Icons.border_color,
                                                    color: Colors.pink),
                                                onTap: () => provider
                                                    .mudaCorTema(Colors.pink),
                                              ),
                                              PopupMenuItem<String>(
                                                value: 'Opção 555',
                                                child: const Icon(
                                                    Icons.border_color,
                                                    color: Colors.purple),
                                                onTap: () => provider
                                                    .mudaCorTema(Colors.purple),
                                              ),
                                              PopupMenuItem<String>(
                                                value: 'Opção 666',
                                                child: const Icon(
                                                    Icons.border_color,
                                                    color: Colors.teal),
                                                onTap: () => provider
                                                    .mudaCorTema(Colors.teal),
                                              ),
                                              PopupMenuItem<String>(
                                                value: 'Opção 4',
                                                child: Icon(Icons.border_color,
                                                    color: Colors.blue[900]!),
                                                onTap: () =>
                                                    provider.mudaCorTema(
                                                        Colors.blue[900]!),
                                              ),
                                              PopupMenuItem<String>(
                                                value: 'Opção 5',
                                                child: const Icon(
                                                    Icons.border_color,
                                                    color: Colors.redAccent),
                                                onTap: () =>
                                                    provider.mudaCorTema(
                                                        Colors.redAccent),
                                              ),
                                              PopupMenuItem<String>(
                                                value: 'Opção 6',
                                                child: const Icon(
                                                    Icons.border_color,
                                                    color: Colors.orangeAccent),
                                                onTap: () =>
                                                    provider.mudaCorTema(
                                                        Colors.orangeAccent),
                                              ),
                                            ],
                                          ).then((value) async => {
                                                await _armazenaACor(
                                                    provider.corTema)
                                              });
                                        },
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
