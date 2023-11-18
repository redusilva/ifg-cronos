import 'package:flutter/material.dart';
import '../../../reutilizáveis/botãoAdaptativo.dart';
import '../../../reutilizáveis/campoAdaptativo.dart';
import 'package:provider/provider.dart';
import '../../../serviços/variaveisDeEstado/CorTema.dart';
import '../../../serviços/variaveisDeEstado/Autenticacao.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';

class FormularioLogin extends StatefulWidget {
  final void Function(String, String, BuildContext) onSubmit;
  final BuildContext _context;
  final SharedPreferences _prefs;
  final String _emailSalvo;
  final String _senhaSalvo;
  final bool _lembrar;

  FormularioLogin(this._lembrar, this._emailSalvo, this._senhaSalvo,
      this._prefs, this.onSubmit, this._context,
      {Key? key})
      : super(key: key) {}

  @override
  State<FormularioLogin> createState() =>
      _FormularioLoginState(_lembrar, _emailSalvo, _senhaSalvo);
}

class _FormularioLoginState extends State<FormularioLogin> {
  final _emailontroller = TextEditingController();

  final _senhaController = TextEditingController();

  bool _textoSenhaOculto = true;

  bool _preferenciasSalvas = false;

  _FormularioLoginState(bool lembrar, String emailSalvo, String senhaSalvo) {
    if (lembrar) {
      _preferenciasSalvas = true;
      _emailontroller.text = emailSalvo;
      _senhaController.text = senhaSalvo;
    }
  }
  _retornarFados() async {
    final email = _emailontroller.text;
    final senha = (_senhaController.text);

    await _armazenaPreferencias();

    widget.onSubmit(email, senha, widget._context);
  }

  Future<void> _armazenaPreferencias() async {
    if (_preferenciasSalvas) {
      await widget._prefs.setString("email", json.encode(_emailontroller.text));
      await widget._prefs
          .setString("senha", json.encode(_senhaController.text));
    } else {
      await widget._prefs.setString("email", json.encode(""));
      await widget._prefs.setString("senha", json.encode(""));
    }

    await widget._prefs.setBool("lembrar", (_preferenciasSalvas));
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
            Text('Fazer Login',
                style: TextStyle(
                  color: Provider.of<CorPrincipal>(context).corTema,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            Builder(
              builder: (context) =>
                  Consumer<Autenticacao>(builder: (context, provider, child) {
                return AdaptativeTextField(
                    label: "Email",
                    controller: _emailontroller,
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: (_) async {
                      await _retornarFados();
                    });
              }),
            ),
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
                          onSubmitted: (_) async {
                            await _retornarFados();
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
                        onSubmitted: (_) async {
                          await _retornarFados();
                        },
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Provider.of<CorPrincipal>(context)
                                .corTema, 
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Provider.of<CorPrincipal>(context)
                                  .corTema, 
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black, 
                        ),
                      ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(_textoSenhaOculto
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () => {
                          setState(() {
                            _textoSenhaOculto = !_textoSenhaOculto;
                          }),
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Lembrar minha identificação",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Checkbox(
                            value: _preferenciasSalvas,
                            onChanged: (bool? value) {
                              setState(() {
                                _preferenciasSalvas = value!;
                              });
                            },
                          ),
                        ],
                      )
                    ]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Builder(
                  builder: (context) => Consumer<Autenticacao>(
                      builder: (context, provider, child) {
                    return AdaptativeButton(
                      "Entrar",
                      Provider.of<CorPrincipal>(context).corTema,
                      () => {
                        _retornarFados(),
                        provider.defineUsuario(
                          _emailontroller.text,
                          _senhaController.text,
                          "...",
                        ),
                      },
                    );
                  }),
                ),
                AdaptativeButton("Cancelar", Colors.red[900],
                    () => Navigator.of(context).pop())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
