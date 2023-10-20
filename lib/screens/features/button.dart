import 'package:flutter/material.dart';

class Button extends ElevatedButton {
  final String value;
  final VoidCallback onPressed;

  Button({super.key, required this.value, required this.onPressed})
      : super(
          onPressed: onPressed,
          child: Text(
            value.toString(),
            style: const TextStyle(fontSize: 20),
          ),
        );
}
