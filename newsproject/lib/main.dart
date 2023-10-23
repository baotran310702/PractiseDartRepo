import 'package:flutter/material.dart';
import 'package:newsproject/home/home.dart';
import 'home/appBar/app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "News App",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBarCustom(),
        body: HomePage(),
      ),
    );
  }
}
