import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Color? color;
  final Function() onPressed;

  const AdaptativeButton(
    this.label,
    this.color,
    this.onPressed, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: color,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          )
        : ElevatedButton(
            child: Text(
              label,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: color, 
            ),
            onPressed: onPressed,
          );
  }
}
