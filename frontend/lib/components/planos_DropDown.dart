import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dropdown extends StatefulWidget {
  final Map<String, String> planos;
  final ValueChanged<String?>? onChanged;
  Dropdown(this.planos, {this.onChanged});

  @override
  String? _selectedvalue;
  _DropdownState createState() => _DropdownState();
  String getValue() {
    return _selectedvalue!;
  }
}

class _DropdownState extends State<Dropdown> {
  String selectedOption = "";

  // Método para obter o valor selecionado
  void setSelectedValue() {
    widget._selectedvalue = widget.planos[selectedOption];
    if (widget.onChanged != null) {
      widget.onChanged!(widget._selectedvalue);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedOption == "") {
      selectedOption = widget.planos.keys.first;
    }
    setSelectedValue();

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      // Para iOS, use o CupertinoPicker
      return Row(
        children: <Widget>[
          const Text(
            "Plano:    ",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectedOption = widget.planos.keys.elementAt(index);
                        setSelectedValue();
                        Navigator.pop(context);
                      });
                    },
                    children: widget.planos.keys.map((String value) {
                      return Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            },
            child: Text(
              selectedOption,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    } else {
      // Para Android, use o DropdownButton
      return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            const Text(
              "Plano:    ",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: selectedOption,
              onChanged: (String? newValue) {
                widget.planos.remove("Selecionar");
                setState(() {
                  selectedOption = newValue!;
                  setSelectedValue();
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.green,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
              elevation: 1,
              underline: Container(
                height: 1,
                color: Colors
                    .green, // Adicionar uma linha de separação personalizada
              ),
              dropdownColor: Colors.green[100], // Cor de fundo do dropdown
              items: widget.planos.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }
  }
}
