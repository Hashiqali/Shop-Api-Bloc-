import 'package:flutter/material.dart';

snackbar(String text, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color.fromARGB(255, 46, 46, 46),
    margin: const EdgeInsets.all(30),
    clipBehavior: Clip.hardEdge,
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Ashi',
          fontWeight: FontWeight.w200),
    ),
  ));
}
