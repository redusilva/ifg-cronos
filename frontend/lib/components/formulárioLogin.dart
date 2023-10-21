import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_text_field.dart';

class FormularioLogin extends StatefulWidget {
  final void Function(String, String, BuildContext) onSubmit;
  final BuildContext _context;
  FormularioLogin(this.onSubmit, this._context, {Key? key}) : super(key: key) {}

  @override
  State<FormularioLogin> createState() => _FormularioLoginState();
}

class _FormularioLoginState extends State<FormularioLogin> {
  final _emailontroller = TextEditingController();
  final _senhaController = TextEditingController();

  _submitForm() {
    final email = _emailontroller.text;
    final senha = (_senhaController.text);
    if (email.isEmpty || senha == "") {
      return;
    }

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
            const Text('Fazer Login', // Título
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20, // Tamanho da fonte do título
                  fontWeight: FontWeight.bold, // Estilo de fonte em negrito
                )),
            AdaptativeTextField(
                label: "Email",
                controller: _emailontroller,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (_) => _submitForm()),
            AdaptativeTextField(
                label: "Senha",
                controller: _senhaController,
                keyboardType: TextInputType.visiblePassword,
                onSubmitted: (_) => _submitForm()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AdaptativeButton("Entrar", Colors.green, _submitForm),
                AdaptativeButton(
                    "Cancelar", Colors.red, () => Navigator.of(context).pop())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
