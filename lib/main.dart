import 'package:flutter/material.dart';
import 'package:news_app/pages/Home.dart';
import 'package:news_app/pages/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 0)),
      home: const SplashScreen(),
    );
  }
}
