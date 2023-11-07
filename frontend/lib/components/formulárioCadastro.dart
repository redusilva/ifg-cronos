import 'adaptative_button.dart';
import 'package:flutter/material.dart';
import 'planos_DropDown.dart';
import 'adaptative_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/customizationProvider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';


class FormularioCadastro extends StatefulWidget {
  final void Function(String, String, String, BuildContext) onSubmit;
  final Map<String, String> planos;
  final Dropdown? _dropdown;
  final BuildContext _context;
  FormularioCadastro(this.onSubmit, this.planos, this._context, this._dropdown,
      {Key? key})
      : super(key: key) {}

  @override
  State<FormularioCadastro> createState() => _FormularioCadastroState();
}

class _FormularioCadastroState extends State<FormularioCadastro> {
  final _emailontroller = TextEditingController();
  final _senhaController = TextEditingController();
  String _idPlano = "";

  bool _textoSenhaOculto=true;

  _submitForm() {
    final email = _emailontroller.text;
    final senha = (_senhaController.text);
    _idPlano = widget._dropdown!.getValue();
    

    widget.onSubmit(email, senha, _idPlano, widget._context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Cadastrar nova conta', // Título
                style: TextStyle(
                  color: Provider.of<CustomProvider>(context).corTema,
                  fontSize: 20, // Tamanho da fonte do título
                  fontWeight: FontWeight.bold, // Estilo de fonte em negrito
                )),
            AdaptativeTextField(
                label: "Email",
                controller: _emailontroller,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (_) => _submitForm()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Platform.isIOS
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: CupertinoTextField(
                          controller: _senhaController,
                          obscureText: _textoSenhaOculto,
                          keyboardType: TextInputType.visiblePassword,
                          onSubmitted: (_) {
                            _submitForm();
                          },
                          placeholder: "Senha",
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 12,
                          ),
                          style: const TextStyle(
                              // color: Colors.green, // Defina a cor do texto
                              ),
                        ),
                      )
                    : TextField(
                        controller: _senhaController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _textoSenhaOculto,
                        onSubmitted: (_) {
                          _submitForm();
                        },
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Provider.of<CustomProvider>(context)
                                .corTema, // Defina a cor do texto do rótulo
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Provider.of<CustomProvider>(context)
                                  .corTema, // Defina a cor da linha inferior
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black, // Defina a cor do texto do campo
                        ),
                      ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  IconButton(
                    icon: Icon(_textoSenhaOculto
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () => {
                      setState(() {
                        _textoSenhaOculto = !_textoSenhaOculto;
                      }),
                    },
                  )
                ]),
              ],
            ),
            widget._dropdown!,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AdaptativeButton("Criar Conta",  Provider.of<CustomProvider>(context)
                    .corTema, _submitForm),
                AdaptativeButton(
                    "Cancelar", Colors.red[900], () => Navigator.of(context).pop()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
