import 'package:expenses/components/adaptative_button.dart';
import 'package:flutter/material.dart';
import 'planos_DropDown.dart';
import 'adaptative_text_field.dart';

class FormularioCadastro extends StatefulWidget {
  final void Function(String, String, String, BuildContext) onSubmit;
  final Map<String, String> planos;
  final Dropdown? _dropdown;
  final BuildContext _context;
  FormularioCadastro(this.onSubmit, this.planos, this._context,this._dropdown, {Key? key})
      : super(key: key) {
  
  }

  @override
  State<FormularioCadastro> createState() => _FormularioCadastroState();
}

class _FormularioCadastroState extends State<FormularioCadastro> {
  final _emailontroller = TextEditingController();
  final _senhaController = TextEditingController();
  String _idPlano = "";

  _submitForm() {
    final email = _emailontroller.text;
    final senha = (_senhaController.text);
    _idPlano = widget._dropdown!.getValue();
    if (email.isEmpty || senha == "" || _idPlano == "") {
      return;
    }

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
            const Text('Cadastrar nova conta', // Título
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
            widget._dropdown!,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AdaptativeButton("Criar Conta", Colors.green, _submitForm),
                AdaptativeButton(
                    "Cancelar", Colors.red, () => Navigator.of(context).pop()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
