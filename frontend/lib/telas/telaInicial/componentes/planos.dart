import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../serviços/variaveisDeEstado/CorTema.dart';

class Planos extends StatefulWidget {
  final Map<String, String> planos;
  final ValueChanged<String?>? onChanged;
  Planos(this.planos, {this.onChanged});

  @override
  String? _selectedvalue;
  _PlanosState createState() => _PlanosState();
  String getValue() {
    return _selectedvalue!;
  }
}

class _PlanosState extends State<Planos> {
  String selectedOption = "";

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
      return Row(
        children: <Widget>[
          Text(
            "Plano:    ",
            style: TextStyle(
              color: Provider.of<CorPrincipal>(context).corTema,
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
                            color: Provider.of<CorPrincipal>(context).corTema,
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
                color: Provider.of<CorPrincipal>(context).corTema,
              ),
            ),
          ),
        ],
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Center(
              child: Text(
                "Plano:    ",
                style: TextStyle(
                  color: Provider.of<CorPrincipal>(context).corTema,
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
                color: Provider.of<CorPrincipal>(context).corTema,
              ),
              style: TextStyle(
                fontSize: 14,
                color: Provider.of<CorPrincipal>(context).corTema,
              ),
              elevation: 2,
              underline: Container(
                height: 2,
                color: Provider.of<CorPrincipal>(context)
                    .corTema, 
              ),
              dropdownColor: Provider.of<CorPrincipal>(context)
                  .corTema, 
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
