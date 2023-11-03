import 'package:expenses/providers/customizationProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupMenuButtonWidget extends StatefulWidget {
  @override
  _PopupMenuButtonWidgetState createState() => _PopupMenuButtonWidgetState();
}

class _PopupMenuButtonWidgetState extends State<PopupMenuButtonWidget> {
  GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Row(
              children: [
                 Text("Cor tema: ", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Provider.of<CustomProvider>(context).corTema
                ),),
                Center(
                  child: Builder(
                    builder: (context) =>
                        Consumer<CustomProvider>(builder: (context, provider, child) {
                      return IconButton(
                        icon: Icon(Icons.border_color,
                            color: provider.corTema),
                        onPressed: () {
                          final RenderBox button =
                              context.findRenderObject() as RenderBox;
                          final RenderBox overlay = Overlay.of(context)
                              .context
                              .findRenderObject() as RenderBox;
                          final RelativeRect position = RelativeRect.fromRect(
                            Rect.fromPoints(
                              button.localToGlobal(Offset.zero, ancestor: overlay),
                              button.localToGlobal(
                                  button.size.bottomRight(Offset.zero),
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
                                  child: const Icon(Icons.border_color,
                                      color: Colors.green),
                                  onTap: () => provider.mudaCorTema(Colors.green)),
                              PopupMenuItem<String>(
                                  value: 'Opção 2',
                                  child: const Icon(Icons.border_color,
                                      color: Colors.amber),
                                  onTap: () => provider.mudaCorTema(Colors.amber)),
                              PopupMenuItem<String>(
                                value: 'Opção 3',
                                child: const Icon(Icons.border_color,
                                    color: Colors.pink),
                                onTap: () => provider.mudaCorTema(Colors.pink),
                              ),
                              PopupMenuItem<String>(
                                value: 'Opção 555',
                                child: const Icon(Icons.border_color,
                                    color: Colors.purple),
                                onTap: () => provider.mudaCorTema(Colors.purple),
                              ),
                              PopupMenuItem<String>(
                                value: 'Opção 666',
                                child: const Icon(Icons.border_color,
                                    color: Colors.teal),
                                onTap: () => provider.mudaCorTema(Colors.teal),
                              ),
                              PopupMenuItem<String>(
                                value: 'Opção 4',
                                child:  Icon(Icons.border_color,
                                    color: Colors.blue[900]!),
                                onTap: () => provider.mudaCorTema(Colors.blue[900]!),
                              ),
                              PopupMenuItem<String>(
                                value: 'Opção 5',
                                child: const Icon(Icons.border_color,
                                    color: Colors.redAccent),
                                onTap: () => provider.mudaCorTema(Colors.redAccent),
                              ),
                              PopupMenuItem<String>(
                                value: 'Opção 6',
                                child: const Icon(Icons.border_color,
                                    color: Colors.orangeAccent),
                                onTap: () => provider.mudaCorTema(Colors.orangeAccent),
                              ),
                            ],
                          );
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
    );
  }
}
