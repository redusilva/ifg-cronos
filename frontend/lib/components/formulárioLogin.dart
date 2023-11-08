import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/customizationProvider.dart';
import '../providers/UserProvider.dart';
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

  //_FormularioLoginState(SharedPreferences _prefs){

  //}

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

  _submitForm() async {
    final email = _emailontroller.text;
    final senha = (_senhaController.text);

    await _armazenaPreferencias();

    widget.onSubmit(email, senha, widget._context);
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
            Text('Fazer Login', // Título
                style: TextStyle(
                  color: Provider.of<CustomProvider>(context).corTema,
                  fontSize: 20, // Tamanho da fonte do título
                  fontWeight: FontWeight.bold, // Estilo de fonte em negrito
                )),
            Builder(
              builder: (context) =>
                  Consumer<EmailProvider>(builder: (context, provider, child) {
                return AdaptativeTextField(
                    label: "Email",
                    controller: _emailontroller,
                    keyboardType: TextInputType.emailAddress,
                    onSubmitted: (_) async {
                      await _submitForm();
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
                            await _submitForm();
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
                        onSubmitted: (_) async {
                          await _submitForm();
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
                  builder: (context) => Consumer<EmailProvider>(
                      builder: (context, provider, child) {
                    return AdaptativeButton(
                      "Entrar",
                      Provider.of<CustomProvider>(context).corTema,
                      () => {
                        _submitForm(),
                        provider.defineUsuario(_emailontroller.text),
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
