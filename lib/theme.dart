import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: Colors.white),
  primaryColor:const Color.fromARGB(255, 7, 144, 255),
  inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Colors.grey,
      )),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Colors.grey,
      )),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 201, 201, 201),
        ),
      )),
);
