import 'package:flutter/material.dart';
import 'package:okoudjoumichael_adebichafine/pages/canditates_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elections',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CandidatesPage(),
    );
  }
}
