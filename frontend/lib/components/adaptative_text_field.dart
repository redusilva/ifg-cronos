import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customizationProvider.dart';

class AdaptativeTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onSubmitted;

  const AdaptativeTextField({
    this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              placeholder: label,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
              style: const TextStyle(
                  // color: Colors.green, // Defina a cor do texto
                  ),
            ),
          )
        : TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: (_text) {
              final String text = _text ?? '';
              if (text.trim().isEmpty) {
                return "" + label.toString() + " é um campo obrigatório";
              }
              return null;
            },
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
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
          );
  }
}
