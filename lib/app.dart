// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fabrics/pages/menu/menu.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff00779a),
          onPrimary: Colors.white,
          secondary: Color(0xffeee5ce),
          onSecondary: Color(0xff38353a),
          error: Color(0xffb00020),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': Menu(),
      }.map((key, value) => MapEntry(key, (_) => value)),
    );
  }
}
