import 'package:flutter/material.dart';
import 'package:uts_grace_2226240079/screen/gempa_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Gempa BMKG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const GempaScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
