import '../../../reutilizáveis/botãoAdaptativo.dart';
import 'package:flutter/material.dart';
import 'planos.dart';
import '../../../reutilizáveis/campoAdaptativo.dart';
import 'package:provider/provider.dart';
import '../../../serviços/variaveisDeEstado/CorTema.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class FormularioCadastro extends StatefulWidget {
  final void Function(String, String, String, BuildContext) retorno;
  final Map<String, String> planos;
  final Planos? _dropdown;
  final BuildContext _context;
  FormularioCadastro(this.retorno, this.planos, this._context, this._dropdown,
      {Key? key})
      : super(key: key) {}

  @override
  State<FormularioCadastro> createState() => _FormularioCadastroState();
}

class _FormularioCadastroState extends State<FormularioCadastro> {
  final _emailontroller = TextEditingController();
  final _senhaController = TextEditingController();
  String _idPlano = "";
  bool _textoSenhaOculto = true;

  _retornarOsDados() {
    final email = _emailontroller.text;
    final senha = (_senhaController.text);
    _idPlano = widget._dropdown!.getValue();
    widget.retorno(email, senha, _idPlano, widget._context);
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
            Text('Cadastrar nova conta',
                style: TextStyle(
                  color: Provider.of<CorPrincipal>(context).corTema,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            AdaptativeTextField(
                label: "Email",
                controller: _emailontroller,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (_) => _retornarOsDados()),
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
                            _retornarOsDados();
                          },
                          placeholder: "Senha",
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 12,
                          ),
                          style: const TextStyle(),
                        ),
                      )
                    : TextField(
                        controller: _senhaController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _textoSenhaOculto,
                        onSubmitted: (_) {
                          _retornarOsDados();
                        },
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Provider.of<CorPrincipal>(context).corTema,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  Provider.of<CorPrincipal>(context).corTema,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
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
                AdaptativeButton(
                    "Criar Conta",
                    Provider.of<CorPrincipal>(context).corTema,
                    _retornarOsDados),
                AdaptativeButton("Cancelar", Colors.red[900],
                    () => Navigator.of(context).pop()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
