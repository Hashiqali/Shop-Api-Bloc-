import 'dart:convert';

import 'package:bloc_project/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<ProductModel>> getallproducts() async {
  const Url =
      'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline';
  Uri uri = Uri.parse(Url);

  final respose = await http.get(uri);

  final json = jsonDecode(respose.body) as List;

  final result = json.map((e) => ProductModel.fromjson(e)).toList();

  return result;
}

snackbar(String text, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color.fromARGB(255, 232, 107, 99),
    margin: const EdgeInsets.all(50),
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
    ),
  ));
}
