import 'package:cuaca/pages/search_field.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tracking Cuaca',
      home: SearchField(), 
    );
  }
}
