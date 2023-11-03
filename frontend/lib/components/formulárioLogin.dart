import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_text_field.dart';
import 'package:provider/provider.dart';
import '../providers/customizationProvider.dart';
import '../providers/UserProvider.dart';

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
                    onSubmitted: (_) {
                      _submitForm();
                    });
              }),
            ),
            AdaptativeTextField(
                label: "Senha",
                controller: _senhaController,
                keyboardType: TextInputType.visiblePassword,
                onSubmitted: (_) {
                  _submitForm();
                }),
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
