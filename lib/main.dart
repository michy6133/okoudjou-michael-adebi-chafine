import 'package:flutter/material.dart';
import 'package:okoudjoumichael_adebichafine/pages/canditates_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elections',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CandidatesPage(),
    );
  }
}
