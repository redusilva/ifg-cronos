import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../serviços/variaveisDeEstado/CorTema.dart';

class AdaptativeTextField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onSubmitted;
  final bool? oculto;

  const AdaptativeTextField({
    this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    this.oculto,
    Key? key,
  }) : super(key: key);

  @override
  State<AdaptativeTextField> createState() => _AdaptativeTextFieldState();
}

class _AdaptativeTextFieldState extends State<AdaptativeTextField> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: widget.controller,
              obscureText: widget.oculto ?? false,
              keyboardType: widget.keyboardType,
              onSubmitted: widget.onSubmitted,
              placeholder: widget.label,
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
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.oculto ?? false,
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              labelText: widget.label,
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
          );
  }
  
}
