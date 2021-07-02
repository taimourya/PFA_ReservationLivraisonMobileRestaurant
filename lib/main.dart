import 'package:flutter/material.dart';
import 'package:restaurant/widgets/Home.dart';
import 'package:restaurant/widgets/Login.dart';

// @dart=2.9
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Application',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Login(),
    );
  }
}