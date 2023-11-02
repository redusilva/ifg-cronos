import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/customizationProvider.dart';

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
          Text(
            "Plano:    ",
            style: TextStyle(
              color: Provider.of<CustomProvider>(context).corTema,
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
                        style: TextStyle(
                            fontSize: 14,
                            color: Provider.of<CustomProvider>(context).corTema,
                            fontWeight: FontWeight.bold),
                      );
                    }).toList(),
                  );
                },
              );
            },
            child: Text(
              selectedOption,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Provider.of<CustomProvider>(context).corTema,
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
            Center(
              child: Text(
                "Plano:    ",
                style: TextStyle(
                  color: Provider.of<CustomProvider>(context).corTema,
                  fontWeight: FontWeight.bold,
                ),
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
              icon: Icon(
                Icons.arrow_drop_down,
                color: Provider.of<CustomProvider>(context).corTema,
              ),
              style: TextStyle(
                fontSize: 14,
                color: Provider.of<CustomProvider>(context).corTema,
              ),
              elevation: 2,
              underline: Container(
                height: 2,
                color: Provider.of<CustomProvider>(context)
                    .corTema, // Adicionar uma linha de separação personalizada
              ),
              dropdownColor: Provider.of<CustomProvider>(context)
                  .corTema, // Cor de fundo do dropdown
              items: widget.planos.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
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
